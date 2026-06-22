class LeaveRequestsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_only, only: [:approve, :reject]



  def index
  if current_user.admin?
    @leave_requests = LeaveRequest.all
  else
    employee = Employee.find_by(email: current_user.email)

    @leave_requests =
      employee.present? ? employee.leave_requests : []
  end
end

  def new
    @leave_request = LeaveRequest.new
  end

  def create

    @leave_request = LeaveRequest.new(leave_request_params)

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

  def leave_request_params
    params.require(:leave_request).permit(
      :employee_id,
      :leave_type,
      :start_date,
      :end_date,
      :reason,
      :medical_document
    )
  end

  def admin_only
    unless current_user.admin?
      redirect_to leave_requests_path,
                  alert: "Access Denied"
    end
  end

end