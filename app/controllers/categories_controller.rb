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
      search_for_stuff
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

  def search_for_stuff
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
        sorted_array = flattened_array.sort_by {|meal| meal.awards.count }
        @meals = sorted_array.reverse!
      end
    end
  end
end
