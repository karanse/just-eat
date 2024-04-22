class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {restaurant: restaurant})
      }
    end
  end
  if params[:query].present?
    sql_subquery = "city ILIKE :query OR postal_code ILIKE :query"
    @restaurants = @restaurants.where(sql_subquery, query: "%#{params[:query]}%")
  end
end
