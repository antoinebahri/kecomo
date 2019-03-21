class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @meals = Meal.all
    @restaurants = Restaurant.all

  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @meals = @restaurant.meals.sort_by { |meal| meal.awards.count }.reverse
    if user_signed_in? && current_user.awards.nil? == false
      # all the awarded categories of the current_user if signed_in
      @current_user_awarded_categories = []
      @current_user_awards = current_user.awards
      @current_user_awards.each do |award|
        @current_user_awarded_categories << award.meal.category
      end
    @current_user_awarded_categories = @current_user_awarded_categories.sort
    end
    @award = Award.new
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
