class MealsController < ApplicationController
  def index
    if params[:query].present?
      @results = PgSearch.multisearch(params[:query])
      unless @results == nil
        @results.each do |result|
          if @results.searchable_type == "Restaurant"
            redirect_to restaurant_meals_path(result.restaurant)
          elsif @results.searchable_type == "Category"
            redirect_to category_meals_path(result.restaurant)
          end
        end
      end


    elsif params[:category_id].present?
      @meals = Meal.all.where(category_id: params[:category_id]).first(10)
      @meals.sort_by! do |meal|
        meal.awards.count
      end
      @meals = @meals.reverse
      # raise
    else
      @meals = Meal.all
    end
  end

  def show
    category = Category.find(params[:category_id])
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
