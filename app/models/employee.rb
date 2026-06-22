class Employee < ApplicationRecord
    has_many :leave_requests, dependent: :destroy
    has_one_attached :profile_picture
end
