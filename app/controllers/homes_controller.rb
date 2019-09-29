class HomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
    @homes = User.where('role <> "admin"')
  end

  # GET /userlist/:type
  def list_users
    if current_user.role == 'admin'
      @users = User.where('role = ?', params[:type])
    elsif current_user.role == 'librarian'
      @users = User.where('role = ?', params[:type])
      # @users = @users.select { |user| 
      #   # UniversityLibraryMapping.where('universities_id = ? and libraries_id = ?', @librarian.libraries_id)
      # }
    end
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      librarian_params_filtered = {
        id: @librarian.id,
        name: librarian_params[:name],
        libraries_id: librarian_params[:libraries_id],
        users_id: @librarian.users_id
      }
      if @librarian.update(librarian_params_filtered)
        format.html { redirect_to '/', notice: 'Librarian profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @librarian }
      else
        format.html { render :edit }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
      # if @user.update(home_params)
      #   format.html { redirect_to @user, notice: 'Home was successfully updated.' }
      #   format.json { render :show, status: :ok, location: @home }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @home.errors, status: :unprocessable_entity }
      # end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      if @user.role == 'librarian'
        @user_library = Library.find(@user.libraries_id) 
      elsif @user.role == 'student'
        @user_university = University.find(@user.universities_id) 
      end
    end

    def set_profile
      id = params[:id]
      if @user.role == 'librarian'
        @profile = Librarian
                  .joins('join libraries on libraries.id = librarians.libraries_id')
                  .where('users_id = ?', id)
                  .select('librarians.*, libraries.name as libraries_name')
                  .first
      else
        # @profile = Student
        #           .where('users_id = ?', id)
        #           .first
      end
    end

    def create_user

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.fetch(:home, {})
    end

    def librarian_params
      params.fetch(:librarian)
    end
end
