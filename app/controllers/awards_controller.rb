class AwardsController < ApplicationController
  def new
    @award = Award.new()
    @restaurant = Restaurant.find(params[:restaurant_id])
    @meal = Meal.find(params[:meal_id])
  end

  def create
    @award = Award.new(set_award_params)
    @meal = Meal.find(params[:meal_id])
    # @category = @meal.category
    @award.user = current_user
    @award.meal = @meal
    # @award.category = @category
    @award.save
    # redirect_to somewhere
  end

  private

  def set_award_params
    params.require(:award).permit(:review)
  end

end
