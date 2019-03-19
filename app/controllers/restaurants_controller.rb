class RestaurantsController < ApplicationController
  def index
    @meals = Meal.all
    @restaurants = Restaurant.all
  end

  def show
    @restaurants = Restaurant.all
    @restaurant = @restaurants.find(params[:id])
    @meals = @restaurant.meals
    @meals.sort_by { |meal| meal.awards.count }
  end

  def map
    @restaurant = Restaurant.find(params[:restaurant_id])
    @markers =
      [{
        lat: @restaurant.latitude,
        lng: @restaurant.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: @restaurant })
      }]
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant = Restaurant.update(restaurant_params)
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to root_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city, :restaurant_category, :description, :opening_hour, :closing_hour, :picture, :latitude, :longitude)
  end
end
