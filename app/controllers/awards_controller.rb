class AwardsController < ApplicationController
  def new
    @award = Award.new
    if params[:restaurant_id].nil?
      @restaurant = Restaurant.new
    else
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
    # the case when the meal is not defined; award given from home or restaurant index
    if params[:meal_id].nil?
      @meal = Meal.new
    else
      @meal = Meal.find(params[:meal_id])
    end
    name = @meal.name
    # raise
  end

  def create
    @award = Award.new(set_award_params)
    @meal = Meal.find(params[:meal_id])
    # @category = @meal.category
    @award.user = current_user
    @award.meal = @meal
    # @award.category = @category
    @award.save
    # redirect_to somwhere
  end

  def destroy
    @award = Award.find(params[:id])
    @award.destroy
    redirect_to profile_path
  end

  private

  def set_award_params
    params.require(:award).permit(:review)
  end

end
