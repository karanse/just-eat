class CityPostalCodeToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :city, :string
    add_column :restaurants, :postal_code, :string
    add_column :restaurants, :street_name, :string
  end
end
