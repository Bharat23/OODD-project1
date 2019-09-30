# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def specify_role
    # keyword = params[:q]
    # type = params[:role]
    # puts 'hehehehehehhee========================' + type
    # if (type == 'librarian')
    #   flash[:notice] = "welcome librarian"
    # else
    #   flash[:notice] = "welcome student"
    # end
  end

  # GET /resource/sign_up
  def new
    puts '================='
    if user_signed_in?
      puts '----------------------'
      if current_user.role == 'admin'
        puts 'adsadasdasdsa'
      else
        super
      end
    else
      super
    end
  end

  # POST /resource
  def create
    puts 'check now'
    # specify_role
    super
  end

  # GET /resource/edit
  def edit
    puts 'sadasdsadsaddasdasdasdasdsad'
    # super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :role, :name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :role, :name])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
