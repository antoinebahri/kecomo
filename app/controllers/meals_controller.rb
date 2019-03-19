class MealsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    query_meals = SearchMeals.new(params)
    if params[:searchquery].present?
      @meals = query_meals.by_text
      # here we are displaying the meals of a particluar CATEGORY
    elsif params[:category_id].present?
      @meals = query_meals.by_category
      # here we are displaying the meals of a particluar RESTAURANT
    elsif params[:restaurant_id].present?
      @mneals = query_meals.by_restaurant
    else
      @meals = Meal.all
    end
    @current_user_awards = current_user.try(:awards)
    @current_user_awarded_categories = current_user.try(:awarded_categories)
  end

  def show
    @category = Category.find(params[:category_id])
    @meal = Meal.find(params[:id])
    @full_score = @meal.awards
  end

  def new
    if user_signed_in?
      @meal = Meal.new
    else
      redirect_to new_user_session_path, notice: 'You need to be logged in to add a new meal.'
    end
  end

  def map
    if params[:category_id].present?
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
