# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"

puts "Cleaning database..."
# Restaurant.destroy_all

puts "Creating restaurants"

postcodes = ['CT12EH', 'BS1 4DJ', 'L4 0TH', 'NE9 7TY', 'SW1A 1AA', 'CF11 8AZ', 'M16 0RA',
            'EH1 1RE', 'BN1 1AE', 'CB7 4DL', 'LS2 7HY', 'G3 8AG', 'PL4 0DW', 'B26 3QJ', 'DH4 5QZ', 'BT7 1NN']
postcode = postcodes[0]
url = "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/#{postcode}"
restaurant_data_serialized = URI.open(url).restaurant_data_serialized
restaurant_data_result = JSON.parse(restaurant_data_serialized)
restaurants_data = restaurant_data_result["restaurants"]

p restaurants_data
