require 'base64'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]


  def search
    keyword = params[:q]
    type = params[:type]
    if (type == 'date_published')
      @books = Book.where(type + ' = ?', keyword)
    else
      @books = Book.where(type + ' ilike ?', '%'+keyword+'%')
    end
  end

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :author, :language, :date_published, :edition, :front_cover_img, :subject, :summary, :special_collection)
    end

    def convert_image(book_params)
      book_params_copy = book_params
      img = book_params_copy['front_cover_img']
      book_params_copy['front_cover_img'] = 'data:' + book_params['front_cover_img'].content_type + ';base64,' + Base64.encode64(img.open.read);
      book_params_copy
    end
end
