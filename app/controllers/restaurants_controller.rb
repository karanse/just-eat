class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude
      }
    end
  end
end
