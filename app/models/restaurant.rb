class Restaurant < ApplicationRecord
  validates :name, :cuisines, :address, presence: true
end
