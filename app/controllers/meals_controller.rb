class MealsController < ApplicationController
  def index
    if params[:query].present?
      @results = PgSearch.multisearch(params[:query])
      raise
    elsif params[:category_id].present?
      @meals = Meal.all.where(category_id: params[:category_id]).first(10)
      @meals.sort_by! do |meal|
        meal.awards.count
      end
      @meals.reverse!
    else
      @meals = Meal.all
    end
  end

  def show
    @meal = Meal.find(params[:id])
    @full_score = @meal.awards
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.create(meal_params)
  end

  def edit
    @meal = Meal.find(params[:restaurant_id])
  end

  def update
    @meal = Meal.find(params[:restaurant_id])
    @meal = Meal.update(meal_params)
  end

  def destroy
    @meal = Meal.find(params[:restaurant_id])
    @meal.destroy
    redirect_to root_path
  end

  private

  # def meal_params
  #   params.require(:meal).permit(:name, :description, :picture)
  # end
end
