class Restaurant < ApplicationRecord
  validates :name, :cuisines, :rating, :address, presence: true
end
