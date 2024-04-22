class RemoveLatitudeLongitudeToRestaurants < ActiveRecord::Migration[7.1]
  def change
    remove_column :restaurants, :latitude, :float
    remove_column :restaurants, :longtitude, :float
  end
end
