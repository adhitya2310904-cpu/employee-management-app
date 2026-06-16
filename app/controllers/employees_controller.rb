class EmployeesController < ApplicationController

  before_action :authenticate_user!

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

end
