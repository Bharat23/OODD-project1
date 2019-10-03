class ApplicationController < ActionController::Base

    def setup_users
        user = User.new(
            email: 'admin@lib.com', 
            password: '123456', 
            password_confirmation: '123456',
            role: 'admin',
            name: 'Admin User'
          )
        user.save!
        user = User.new(
            email: 'librarian@lib.com', 
            password: '123456', 
            password_confirmation: '123456',
            role: 'librarian',
            name: 'Librarian User',
            libraries_id: 1
          )
        user.save!
        user = User.new(
            email: 'student@lib.com', 
            password: '123456', 
            password_confirmation: '123456',
            role: 'student',
            name: 'Student User',
            universities_id: 1,
            educational_level: 'Masters',
            borrowing_limit: 10
          )
        user.save!
        redirect_to '/'
    end

    protected
    def authenticated_user!
        if user_signed_in?
            authenticate_user!
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
