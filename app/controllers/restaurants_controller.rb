class RestaurantsController < ApplicationController
  def index
    # check if user searched an area post code
    if params[:query].present?
      postcode = params[:query]
      # check if searched postcode restaurants in DB, else fetch & add them to the DB
      if need_to_fetch_restaurants?(postcode)
        fetch_and_save_restaurants(postcode)
      end
      @restaurants = Restaurant.where(search_postal_code: params[:query]).order(rating: :desc).limit(12)
    else
      @restaurants = Restaurant.first(12)
    end

    # get the markers for each restaurant coordinates to be able to add on map
    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {restaurant: restaurant})
      }
    end
  end

  private

  # check if searched postcode data already in DB
  def need_to_fetch_restaurants?(postcode)
    Restaurant.where(search_postal_code: postcode).empty?
  end

  # fetch and save searched postcode data to the DB
  def fetch_and_save_restaurants(postcode)
    puts "Fetching and saving restaurants for postcode: #{postcode}"

    url = "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/#{postcode}"
    begin
      data_serialized = URI.open(url).read
      data_result = JSON.parse(data_serialized)
      restaurants_data = data_result['restaurants'].first(12)

      restaurants_data.each do |restaurant|
        new_restaurant = Restaurant.new(
          name: restaurant['name'].split('-')[0],
          rating: restaurant['rating']['starRating'].to_f,
          rating_count: restaurant['rating']['count'].to_i,
          city: restaurant['address']['city'],
          street_name: restaurant['address']['firstLine'],
          search_postal_code: postcode,
          postal_code: restaurant['address']['postalCode'],
          address: "#{restaurant['address']['firstLine']}, #{restaurant['address']['postalCode']}, #{restaurant['address']['city']}",
          cuisines: restaurant['cuisines'][0]['name'],
          logo_url: restaurant['logoUrl'],
          latitude: restaurant['address']['location']['coordinates'][1],
          longitude: restaurant['address']['location']['coordinates'][0]
        )

        if new_restaurant.save
          puts "Saved restaurant: #{restaurant['name']}"
        else
          puts "Validation failed for restaurant: #{restaurant['name']}"
          puts new_restaurant.errors.full_messages.inspect
        end
      end

      puts 'Finished fetching and saving restaurants.'
    rescue => e
      puts "An error occurred: #{e.message}"
      puts e.backtrace.inspect
    end
  end
end
