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
    @award.user = current_user
    @award.meal = @meal
    # Now need to clear all awards of the user in the current category before save of new award in that same category
    current_user_awards = current_user.awards
    awards_from_category_to_release = current_user_awards.find_all { |award| award.meal.category = @meal.category }
    # Award.destroy(awards_from_category_to_releasemap.map(&:id))
    indexes_to_destroy = awards_from_category_to_releasemap.map(&:id)
    indexes_to_destroy.each do |index|
      Award.where(id: index).destroy_all
    end
    @award.save
    # redirect_to somwhere
  end

  def destroy
    @award = Award.find(params[:award_id])
    @award.destroy
  end

  private

  def set_award_params
    params.require(:award).permit(:review)
  end

end
