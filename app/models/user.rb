class User < ApplicationRecord

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  after_create :create_employee_profile, if: :employee?

  def admin?
    role == "admin"
  end

  def employee?
    role == "employee"
  end

  private

  def create_employee_profile
    Employee.create!(
      email: email,
      name: email.split("@").first.titleize,
      leave_balance: 20
    )
  end

end