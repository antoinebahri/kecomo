class MealsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:searchquery].present?
      @results = PgSearch.multisearch(params[:searchquery])
      unless @results.nil?
        all_results_array = []
        @results.each do |result|
          if result.searchable_type == "Restaurant"
            resto = result.searchable
            all_results_array << resto.meals
          elsif result.searchable_type == "Category"
            catego = result.searchable
            all_results_array << catego.meals
          elsif result.searchable_type == "Meal"
            meal = result.searchable
            all_results_array << meal
          end
          flattened_array = all_results_array.flatten
          sorted_array = flattened_array.sort_by {|meal| meal.awards.count}
          @meals = sorted_array.reverse!.uniq
        end
      end
      # raise
    elsif params[:category_id].present?
      @meals = Meal.all.where(category_id: params[:category_id])
      @sorted_meals = @meals.sort_by do |meal|
        meal.awards.count
      end
      @sorted_meals.first(10)
      @meals = @sorted_meals.reverse
    else
      @meals = Meal.all
    end
    # raise
    @current_user_awarded_categories = []
    @current_user_awards = current_user.awards
    @current_user_awards.each do |award|
      @current_user_awarded_categories << award.meal.category
    end
    @current_user_awarded_categories = @current_user_awarded_categories.sort
    # raise
  end

  def show
    @category = Category.find(params[:category_id])
    @meal = Meal.find(params[:id])
    @full_score = @meal.awards

    @markers =
      [{
        lat: @meal.restaurant.latitude,
        lng: @meal.restaurant.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: @meal.restaurant })
      }]
  end

  def map
    if params[:id].present?
    @category = Category.find(params[:category_id]).first(10)
    @meal = Meal.find(params[:id])
    @markers =
      [{
        lat: @meal.restaurant.latitude,
        lng: @meal.restaurant.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: @meal.restaurant })
      }]
    else
    @meals = Meal.all.where(category_id: params[:category_id])
    @markers = @meals.map do |meal|
      {
        lat: meal.restaurant.latitude,
        lng: meal.restaurant.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: meal.restaurant })
      }
    end
    end
  end

  def new
    if user_signed_in?
      @meal = Meal.new
    else
      redirect_to new_user_session_path, notice: 'You need to be logged in to add a new meal.'
    end
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :new
    end
  end

  def edit
    if user_signed_in?
      @meal = Meal.find(params[:restaurant_id])
    else
      redirect_to new_user_session_path, notice: 'You need to be logged in to edit a meal.'
    end
  end

  def update
    @meal = Meal.find(params[:restaurant_id])
    if @meal.update(meal_params)
      redirect_to meal_path(@meal)
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in?
      @meal = Meal.find(params[:restaurant_id])
      @meal.destroy
    else
      redirect_to new_user_session_path, notice: 'You need to be logged in to delete a meal.'
    end
    redirect_to root_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :picture)
  end
end
