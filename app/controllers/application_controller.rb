class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :set_current_employee

  protected

  def after_sign_in_path_for(resource)
    resource.admin? ? employees_path : employee_dashboard_path
  end

  private

  def set_current_employee
    return unless user_signed_in?

    @current_employee = Employee.find_by(
      email: current_user.email
    )
  end
end