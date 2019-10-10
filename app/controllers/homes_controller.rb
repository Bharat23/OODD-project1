class HomesController < ApplicationController
  before_action :authenticated_user!
  before_action :is_admin!, only: [:new_user_by_admin]
  before_action only: [:edit, :show] do 
    only_for_me(params[:id], allow_for_admin=true)
  end
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
      library_obj = Library.find(current_user.libraries_id)
      universities_id = library_obj.universities_id
      @users = User.where('role = ? and universities_id = ?', params[:type], universities_id)
    end
  end

  # GET /profile/1
  # GET /profile/1.json
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
      @user = User.find(params[:id])
      cols = {
        name: params[:user][:name]
      }
      if @user.role == 'librarian'
        cols['libraries_id'] = params[:user][:libraries_id]
      elsif @user.role == 'student'
        cols['universities_id'] = params[:user][:universities_id]
        cols['educational_level'] = params[:user][:educational_level]
        cols['borrowing_limit'] = if params[:user][:educational_level] == 'Undergrad'
                                    2
                                  else
                                    params[:user][:educational_level] == 'Masters' ? 4 : 6
                                  end
      end
      if @user.update_attributes(cols)
        format.html { redirect_to '/', notice: 'Your profile was successfully updated.' }
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
      format.html { redirect_to homes_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_user_by_admin
  end

  def create_user_by_admin
    puts params
    user_params = {
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      role: params[:role],
      is_approved: 1
    }
    @new_user = User.new(user_params)
    
    respond_to do |format|
      if @new_user.save
        format.html { redirect_to '/', notice: 'New user created successfully.' }
        format.json { render :show, status: :ok, location: @new_user }
      else
        format.html { redirect_to :edit }
        format.json { render :show, status: :ok, location: @new_user }
      end
    end

  def new_update_password
  end

  def create_update_password
  end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      if @user.role == 'librarian'
        if @user.libraries_id
          @user_library = Library.find(@user.libraries_id) 
        else
          @user_library = Library.new
        end
      elsif @user.role == 'student'
        if (@user.universities_id)
          @user_university = University.find(@user.universities_id) 
        else
          @user_university = University.new
        end
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