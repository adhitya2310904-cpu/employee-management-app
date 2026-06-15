class EmployeesController < ApplicationController

  before_action :authorize_user

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to employees_path
    else
      render :new
    end
  end

  private

  def employee_params
    params.require(:employee)
          .permit(:name, :email, :department, :salary)
  end

  def authorize_user
    redirect_to login_path unless session[:user_id]
  end

end
