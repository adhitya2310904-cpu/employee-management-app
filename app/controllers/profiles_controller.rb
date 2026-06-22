class ProfilesController < ApplicationController

  before_action :authenticate_user!
  

  def show
    @employee = Employee.find_by(
      email: current_user.email
    )
  end

end
