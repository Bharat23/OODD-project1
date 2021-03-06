 require 'base64'

# use this code to send the mailer
# BookIssueMailer.book_issued_email(<student_id>, <book_id>).deliver_now

class BooksController < ApplicationController
  before_action only: [:new, :create, :edit, :update] do 
    allowed_users(['admin', 'librarian'])
  end
  before_action :set_vars
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def search
    keyword = params[:q]
    type = params[:type]
    if (type == 'date_published')
      @books = Book.where(type + ' = ?', keyword)
    else
      @books = Book.where('lower('+ type +') like ?', '%'+keyword+'%')
    end
  end

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    if current_user.role == 'librarian'
      listtype = params[:listtype]
      if listtype == 'available'
        @books = Book.where('libraries_id is null')
      else
        @books = Book.where('libraries_id = ?', current_user.libraries_id)
      end
    elsif current_user.role == 'student'
        library_list = Library.where('universities_id = ?', current_user.universities_id)
        puts library_list
        lib = library_list.map { |l|
          l.id
        }
        @books = Book.where('libraries_id is not null')
        @books.select { |book|
          if lib.include?(book.libraries_id)
            return true
          else
            return false
          end
        }
end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    if current_user.role == 'librarian'
      if @book.libraries_id && @book.libraries_id != current_user.libraries_id
        redirect_to '/'
      end
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    if current_user.role == 'librarian'
      if @book.libraries_id != current_user.libraries_id
        redirect_to '/'
      end
    end
  end

  # POST /books
  # POST /books.json
  def create
    book_params_copy = convert_image(book_params)
    @book = Book.new(book_params_copy)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    book_params_copy = convert_image(book_params)
    respond_to do |format|
      if @book.update(book_params_copy)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def bookmark
    book_id = params[:id]
    user_id = current_user.id
    bookmark = Bookmark.where('books_id = ? and users_id =?', book_id,user_id)
    params_filtered = { users_id: user_id, books_id: book_id}
    @bookmarks = Bookmark.new(params_filtered)
    respond_to do |format|
      if bookmark.exists?
        format.html { redirect_to request.referrer , notice: 'Bookmark already saved.' }
        format.json { render :show, status: :created, location: @library }
      else
        @bookmarks.save
        format.html { redirect_to request.referrer, notice:'Created Bookmark' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end

  end
  
  def checkout
    book_id = params[:id]
    libraries_id = Book.find(book_id).libraries_id
    user_id = current_user.id
    if user_checked_out(book_id, libraries_id, user_id)
      respond_to do |format|
        format.html { redirect_to request.referrer , notice: 'Already Issued ' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    else
    if check_user_limit(user_id)
      @action_log  = 1 # Reached max borrowing limit
      update_status(user_id, book_id, @action_log, libraries_id)
      respond_to do |format|
        format.html { redirect_to request.referrer , notice: 'Reached maximum issue limit' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    else
      if is_special_collection?(book_id)
        @action_log = 2 # Librarian approval needed since it is special collection book
        update_status(user_id, book_id, @action_log, libraries_id)
       # notify_librarian(user_id, book_id, libraries_id)
       #
        respond_to do |format|
          format.html { redirect_to request.referrer , notice: 'The Book needs Librarian approval. Thank you for patience!' }
          format.json { render json: @library.errors, status: :unprocessable_entity }
        end
      else
        if !book_available_for_issue(book_id, libraries_id)
          @action_log= 3 # No book available for issue
          #update_status(user_id, book_id, @action_log, libraries_id)
          waitlist(book_id)
          respond_to do |format|
            format.html { redirect_to request.referrer , notice: 'All the books have been issued and you are on the waitlist' }
            format.json { render json: @library.errors, status: :unprocessable_entity }
          end
        else

          @action_log = 4 # Book issued
          #book_specified_library= LibraryBookMapping.where('libraries_id = ? AND books_id =? ', libraries_id, book_id).pluck(:book_count)
          #library_book_count = book_specified_library[0]
          respond_to do |format|
              book_count = Book.find(book_id).book_count
              book_count = book_count-1
              libraries_id = Book.find(book_id).libraries_id
              due_date = Date.today + (Library.find(libraries_id).borrow_duration)
              last_updated = DateTime.now
              reason = "Normal Book Issue"
              fine_amount = Library.find(libraries_id).fine_per_day * (Date.today - due_date)
              if fine_amount < 0
                fine_amount = 0
              end
              action_log = @action_log
              @checkout_book = BookIssueTransaction.new(users_id: current_user.id, books_id: book_id, libraries_id: libraries_id, status: @action_log, due_date: due_date, last_updated: last_updated, reason: reason, fine_amount: fine_amount).save
              @update_books_count = Book.where(id: book_id).update(book_count: book_count)
              format.html { redirect_to books_url   , notice:'Book Checked out Successfully' }
              format.json { render :show, status: :created, location: @library }
          end
        end
      end
      end
    end
    @insert_log = TransactionLog.new(books_id: book_id, users_id: current_user.id, action: @action_log, timestamp_of_action: DateTime.now).save
  end

  def book_issued_list
    user_id = params[:id]
    @book_issued = BookIssueTransaction.where(users_id: user_id).pluck(:books_id)
    @book = Book.find(@book_issued)
    fine_amount = BookIssueTransaction.where(users_id: user_id).pluck(:fine_amount)
    @total_fine = fine_amount.sum
  end


  def book_return
    user_id = current_user.id
    book_id = params[:id]
    book_count = Book.find(book_id).book_count + 1
    libraries_id = Book.find(book_id).libraries_id
    @action_log  = 5 # Book returned
    update_status(user_id, book_id, @action_log, libraries_id)
    @update_books_count = Book.where(id: book_id).update(book_count: book_count)
    @insert_log = TransactionLog.new(books_id: book_id, users_id: current_user.id, action: @action_log, timestamp_of_action: DateTime.now).save
    BookIssueTransaction.where(users_id: user_id, books_id: book_id).destroy_all
    # Get user from waitlist table (1st row if exists)
    user_waitlisted = Waitlist.where("books_id =?",book_id)

    if user_waitlisted.exists?
      waitlist_id = user_waitlisted.pluck(:users_id)[0]
      first_user_in_waitlist = user_waitlisted.first
    # delete the record from waitlist
      first_user_in_waitlist.destroy
    # issue the book to user id from waitlist
      book_count = book_count - 1
      due_date = Date.today + (Library.find(libraries_id).borrow_duration)
      last_updated = DateTime.now
      reason = "Normal Book Issue"
      fine_amount = Library.find(libraries_id).fine_per_day * (Date.today - due_date)
      if fine_amount < 0
        fine_amount = 0
      end
      action_log = 4
      @checkout_book = BookIssueTransaction.new(users_id: waitlist_id, books_id: book_id, libraries_id: libraries_id, status: action_log, due_date: due_date, last_updated: last_updated, reason: reason, fine_amount: fine_amount).save
      @update_books_count = Book.where(id: book_id).update(book_count: book_count)
    end
    respond_to do |format|
      format.html { redirect_to request.referrer , notice: 'Book returned !!' }
    end

  end

  def user_checked_out(book_id, libraries_id, user_id)
    return BookIssueTransaction.exists?(users_id: user_id, books_id: book_id, libraries_id: libraries_id)
  end

  def check_user_limit(user_id)
    user_id = current_user.id
    issued_book_count = BookIssueTransaction.where(:users_id => user_id).count
    borrowing_limit = User.where('id = ?',user_id).pluck(:borrowing_limit)
    return issued_book_count == borrowing_limit[0] ? true : false
  end

  def is_special_collection?(book_id)
    return Book.find(book_id).special_collection
  end

  def book_available_for_issue(book_id,libraries_id)
    #issued_book_count = BookIssueTransaction.where('books_id =? and libraries_id =?',book_id,libraries_id).count
    total_book_count = Book.where(id: book_id).pluck(:book_count)[0]
  #  return issued_book_count < total_book_count ? true : false
    return total_book_count > 0 ? true : false
  end

  def checkout_hold_list
    #@list_of_holds = BookIssueTransaction.where('status = ?', 2)
  end

  def update_status(user_id, book_id, action_log, libraries_id)


    libraries_id = Book.find(book_id).libraries_id
    due_date = Date.today + (Library.find(libraries_id).borrow_duration)
    last_updated = DateTime.now
    reason = "Normal Book Issue"
    fine_amount = Library.find(libraries_id).fine_per_day * (Date.today - due_date)
    if fine_amount < 0
      fine_amount = 0
    end
    if BookIssueTransaction.where('users_id = ? and books_id = ?', user_id, book_id).exists?
      BookIssueTransaction.where('books_id = ? and users_id = ?', book_id, user_id).update(status: @action_log)
    else
      BookIssueTransaction.new(users_id: current_user.id, books_id: book_id, libraries_id: libraries_id, status: @action_log, due_date: due_date, last_updated: last_updated, reason: reason, fine_amount: fine_amount).save
    end
  end

  def waitlist(book)
    user_id = current_user.id
    libraries_id = Book.find(book).libraries_id
    action_log = 2 #Book Waitlisted
    @book_count = Book.find(book).book_count
    if @book_count == 0
      Waitlist.new(books_id: book, users_id: user_id ,created_at: DateTime.now).save
      TransactionLog.new(books_id: book, users_id: current_user.id, action: @action_log, timestamp_of_action: DateTime.now).save
    end
  end
  # /books/borrow-history/:id
  def borrow_history
    @book = Book.find(params[:book_id])
    @transaction_log = TransactionLog.where('books_id = ?', params[:book_id])
  end


  #show checked out books list ---to admin and librarian
  def checked_out_books
    @user_id = params[:user_id]
    if @user_id == 'admin'
      @record = BookIssueTransaction.where('status = ?', '4')
    else
      @record = BookIssueTransaction.where('status = ? and libraries_id = ?', '4', @user_id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :author, :language, :date_published, :edition, :front_cover_img, :subject, :summary, :special_collection, :book_count)
    end

    def convert_image(book_params)
      book_params_copy = book_params
      img = book_params_copy['front_cover_img']
      if img
        book_params_copy['front_cover_img'] = 'data:' + book_params['front_cover_img'].content_type + ';base64,' + Base64.encode64(img.open.read);
      else
        book_params_copy['front_cover_img'] = ''
      end
      if current_user.role == 'librarian'
        book_params_copy['libraries_id'] = current_user.libraries_id
      end
      book_params_copy
    end

    def set_vars
      @action_log_array = [
        '',
        'Reached max borrowing limit',
        'Librarian approval needed since it is special collection book',
        'No book available for issue',
         'Book issued',
      'Book returned',
      'Book Waitlisted',
      ]
    end
end

