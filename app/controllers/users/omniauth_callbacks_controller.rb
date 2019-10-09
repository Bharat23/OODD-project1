# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  @@check = 'nononononnononononnonno'
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  def passthru
    puts 'asdasdsadasdasdasdasdasdasdasdasdasdasdasd============'
    puts params[:type]
    session[:notice] = 'HEy THEREE SOOOOOOOO!!!!!!!!!!!!!!!!!'
    @@check = 'yyoyoyoyoyoyoyoyooyoyoyoyoyoyoyoy'
    # super
  end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def google_oauth2
    puts request.env['omniauth.auth'].inspect
    puts session[:notice]
    puts @@check
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      puts 'ananananannanaannananananan'
      flash[:notice] = 'There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
    redirect_to new_user_registration_url
  end

end
