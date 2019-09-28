class ApplicationController < ActionController::Base

    def setup_users
        user = User.new(
            email: 'bsinha2@ncsu.edu', 
            password: '123456', 
            password_confirmation: '123456',
            role: 'admin'
          )
        user.save!
        user = User.new(
            email: 'new@email.edu', 
            password: '123456', 
            password_confirmation: '123456',
            role: 'librarian'
          )
        user.save!
        user = User.new(
            email: 'student@email.edu', 
            password: '123456', 
            password_confirmation: '123456',
            role: 'student'
          )
        user.save!
        redirect_to '/'
    end

    protected
    def authenticate_user!
        if user_signed_in?
            super
        else
            redirect_to new_user_session_path, :notice => 'Please login first'
            ## if you want render 404 page
            ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
        end
    end

    def is_admin!
        if user_signed_in?
            if current_user.role == 'admin'
                return true
            else
                redirect_to '/'
            end
        else
            redirect_to '/'
        end
    end

    def is_librarian!
        if user_signed_in?
            if current_user.role == 'librarian'
                return true
            else
                redirect_to '/'
            end
        else
            redirect_to '/'
        end
    end

    def is_student!
        if user_signed_in?
            puts 'asdsad' + current_user.role
            if current_user.role == 'student'
                return true
            else
                redirect_to '/'
            end
        else
            redirect_to '/'
        end
    end
end
