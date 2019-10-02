class ApprovalsController < ApplicationController
    before_action :is_admin!

    def list_user_signup_approval
        @user_for_approval = User.where("role = ? and is_approved = ?", 'librarian', 0)
    end

    def approve_reject_signup
        approval_type = params[:type]
        id = params[:id]
        @user_for_approval = User.find(id)
        respond_to do |format|
            if @user_for_approval.update_attribute(:is_approved, approval_type)
                ApprovalMailer.account_approve_email(id).deliver_now
                format.html { redirect_to list_user_signup_approval_path, notice: 'Request processed successfully' }
                format.json { render :show, status: :ok, location: @book }
            else
                format.html { render :edit }
                format.json { render json: @book.errors, status: :unprocessable_entity }
            end
        end
    end
end