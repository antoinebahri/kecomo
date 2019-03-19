class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(cat_params)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category = Category.update(cat_params)
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
    elsif params[:searchquery].present?
      @meals = SearchMeals.new(params).by_text
      @restaurants = []
      @meals.each do |meal|
        @restaurants << Restaurant.find(meal.restaurant_id)
      end
      @markers = @restaurants.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude,
          infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: restaurant })
        }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to root_path
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end
end
