class LibrariesController < ApplicationController
  # before_action :is_admin!
  before_action :set_library, only: [:show, :edit, :update, :destroy]
  before_action :is_librarian!, only: [:add_book_library, :add_update_book_library]

  # GET /libraries
  # GET /libraries.json
  def index
    @libraries = Library.all
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  def create
    university_id = library_params[:university_id]
    library_params_filtered = {
      name: library_params[:name],
      location: library_params[:location],
      borrow_duration: library_params[:borrow_duration],
      fine_per_day: library_params[:fine_per_day],
      universities_id: university_id
    }
    @library = Library.new(library_params_filtered)
    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET 
  def add_book_library
    book_id = params[:book_id]
    libraries_id = current_user.libraries_id
    books = LibraryBookMapping.where('libraries_id = ? and books_id = ?', libraries_id, book_id).first
    if books == nil
      @library_book_mapping = LibraryBookMapping.new
    else
      @library_book_mapping = books
    end
  end

  def add_update_book_library
    libraries_id = current_user.libraries_id
    book_count = params[:library_book_mapping][:book_count]
    book_id = params[:book_id]
    books = LibraryBookMapping.where('libraries_id = ? and books_id = ?', libraries_id, book_id).first
    params_filtered = { book_count: book_count, books_id: book_id, libraries_id: libraries_id }
    if books == nil
      @library_book_mapping = LibraryBookMapping.new(params_filtered)
      respond_to do |format|
        if @library_book_mapping.save
          format.html { redirect_to '/', notice: 'Book was successfully added/updated.' }
          format.json { render :show, status: :created, location: @library }
        else
          format.html { render :new }
          format.json { render json: @library.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @library_book_mapping = books
        if @library_book_mapping.update(params_filtered)
          format.html { redirect_to '/', notice: 'Book was successfully added/updated.' }
          format.json { render :show, status: :ok, location: @library }
        else
          format.html { render :edit }
          format.json { render json: @library.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    respond_to do |format|
      university_id = library_params[:university_id]
      library_params_filtered = {
        name: library_params[:name],
        location: library_params[:location],
        borrow_duration: library_params[:borrow_duration],
        fine_per_day: library_params[:fine_per_day],
        universities_id: university_id
      }
      if @library.update(library_params_filtered)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url, notice: 'Library was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
      if @library.universities_id
        @university = University.find(@library.universities_id)
      else
        @university = University.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:name, :location, :borrow_duration, :fine_per_day, :university_id)
    end
end
