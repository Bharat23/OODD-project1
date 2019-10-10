class HoldRequestsController < ApplicationController

  def checkout_hold_list
    @user_id = params[:user_id]
    if @user_id == 'admin'
      @list_of_holds = BookIssueTransaction.where('status = ?', '2')
    else
      @list_of_holds = BookIssueTransaction.where('status = ? and users_id = ?', '2', @user_id)
    end
  end

  def delete_hold_request
    @stud_id = params[:stud_id]
    @b_id = params[:b_id]
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    BookIssueTransaction.where('status = ? and books_id = ? and users_id = ?', '2', @b_id, @stud_id).update(status: 0)
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'deleted' }
    end
  end
end