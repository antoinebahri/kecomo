class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @meals = @restaurant.meals
    @meals = @meals.sort_by {|meal| meal.awards.count}
    @meals = @meals.reverse
    # raise
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
