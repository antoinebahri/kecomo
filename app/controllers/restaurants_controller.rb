class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @rest_by_cat_by_city = Restaurant.search_by_cat(params[:category].name).where(params[:city])
    raise
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
