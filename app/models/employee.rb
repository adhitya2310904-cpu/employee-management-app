class Employee < ApplicationRecord
    has_many :leaves, dependent: :destroy
end
