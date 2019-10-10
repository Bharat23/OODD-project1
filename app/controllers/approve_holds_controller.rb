class ApproveHoldsController < ApplicationController
  def show_hold_requests
    lib_id = params[:libraries_id]
    @pending_approval = BookIssueTransaction.where("status = ? and libraries_id = ?", '2', lib_id)
  end

  def approve_reject_request
    record_id = params[:record_id].to_i
    type = params[:approval_type].to_i
    #puts "+++++++++++++++++++++++++++++++++++"
    @request = BookIssueTransaction.find(record_id)
    @libraries_id = @request.libraries_id
    if type == 1
      BookIssueTransaction.update(record_id, status: 4)
    else if type == 2
           BookIssueTransaction.update(record_id, status: 5)
         end
    end
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Request processed successfully' }
    end
      end
    end