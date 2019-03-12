class RestaurantsController < ApplicationController
  def index
    @meals = Meal.all

  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  # def new
  #   @restaurant = Restaurant.new
  # # end

  def create
    @restaurant = Restaurant.create(restaurant_params)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :city)
  end
end
