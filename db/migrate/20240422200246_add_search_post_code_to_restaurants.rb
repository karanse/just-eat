class AddSearchPostCodeToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :search_postal_code, :string
  end
end
