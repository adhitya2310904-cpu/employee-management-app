class EmployeeMailer < ApplicationMailer

  def welcome_email(employee)

    @employee = employee

    mail(
      to: @employee.email,
      subject: "Welcome to Employee Management System"
    )

  end

end