class LeaveRequestsController < ApplicationController

  before_action :authenticate_user!

  def index
    @leave_requests = LeaveRequest.all.order(created_at: :desc)
  end

  def new
    @leave_request = LeaveRequest.new
  end

  def create

    @leave_request = LeaveRequest.new(leave_params)

    @leave_request.status = "Pending"

    if @leave_request.save
      redirect_to leave_requests_path,
                  notice: "Leave Request Submitted"
    else
      render :new, status: :unprocessable_entity
    end

  end

  def approve

    leave_request = LeaveRequest.find(params[:id])

    leave_request.update(status: "Approved")

    leave_request.employee.decrement!(
      :leave_balance,
      (leave_request.end_date - leave_request.start_date).to_i + 1
    )

    redirect_to leave_requests_path

  end

  def reject

    leave_request = LeaveRequest.find(params[:id])

    leave_request.update(status: "Rejected")

    redirect_to leave_requests_path

  end

  private

  def leave_params

    params.require(:leave_request).permit(
      :employee_id,
      :leave_type,
      :start_date,
      :end_date,
      :reason,
      :medical_document
    )

  end

end