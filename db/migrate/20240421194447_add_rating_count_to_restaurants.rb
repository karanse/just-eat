class AddRatingCountToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :rating_count, :integer
  end
end
