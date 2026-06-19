class AddLeaveBalanceToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :leave_balance, :integer
  end
end
