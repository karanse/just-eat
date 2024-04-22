# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'
require 'open-uri'

puts 'Cleaning database...'
Restaurant.destroy_all

puts 'Creating restaurants from sample UK post codes'

postcodes = ['CT12EH', 'BS14DJ', 'L40TH', 'NE97TY', 'SW1A1AA', 'CF118AZ', 'M160RA',
             'EH11RE', 'BN11AE', 'CB74DL', 'LS27HY', 'G38AG', 'PL40DW', 'B263QJ', 'DH45QZ', 'BT71NN']

postcodes.each do |postcode|
  url = "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/#{postcode}"
  begin
    data_serialized = URI.open(url).read
    data_result = JSON.parse(data_serialized)
    restaurants_data = data_result['restaurants'].first(12)
    # cuisines = data_result['cuisineDetails']

    restaurants_data.each do |restaurant|
      puts "Processing restaurant: #{restaurant['name']}"
      new_restaurant = Restaurant.new(
        name: restaurant['name'].split("-")[0],
        rating: restaurant['rating']['starRating'].to_f,
        rating_count: restaurant['rating']['count'].to_i,
        city: restaurant['address']['city'],
        street_name: restaurant['address']['firstLine'],
        search_postal_code: postcode,
        postal_code: restaurant['address']['postalCode'],
        address: "#{restaurant['address']['firstLine']}, #{restaurant['address']['postalCode']}, #{restaurant['address']['city']}",
        # cuisines: restaurant['cuisines'][0]['name'],
        cuisines: restaurant['cuisines'].map {|cuisine| cuisine['name']}.join(", "),
        # cuisine_tags: restaurant['cuisines'].map { |cuisine| cuisine['name'] }.join(", "),
        logo_url: restaurant['logoUrl'],
        latitude: restaurant['address']['location']['coordinates'][1],
        longitude: restaurant['address']['location']['coordinates'][0]
      )
      if new_restaurant.valid?
        new_restaurant.save
        puts "Saved restaurant: #{restaurant['name']}"
      else
        puts "Validation failed for restaurant: #{restaurant['name']}"
        puts new_restaurant.errors.full_messages.inspect
      end
    end

    puts 'Finished!'
  rescue => e
    puts "An error occurred: #{e.message}"
    puts e.backtrace.inspect
  end
end
