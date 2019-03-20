class SearchMeals
  def initialize(params)
    @params = params
  end

  def by_text
    results = PgSearch.multisearch(@params[:searchquery])
    meals = [];
    unless results.nil?
      all_results_array = []
      results.each do |result|
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
        # sorted_array = flattened_array.sort_by { |meal| meal.awards.count }
        # @meals = sorted_array.reverse!
        sorted_array = flattened_array.sort_by { |meal| meal.awards.count }
        meals = sorted_array.reverse!.uniq
      end
    end
    meals
  end

  def by_category
    meals = Meal.all.where(category_id: @params[:category_id])
    sorted_meals = meals.sort_by do |meal|
      meal.awards.count
    end
    sorted_meals.reverse
  end

  def by_restaurant
    meals = Meal.all.where(restaurant_id: @params[:restaurant_id])
    sorted_meals = meals.sort_by { |meal| meal.awards.count }
    sorted_meals.first(10)
    sorted_meals.reverse
  end
end
