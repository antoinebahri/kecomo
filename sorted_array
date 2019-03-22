
[1mFrom:[0m /home/ngilmichel/code/antoinebahri/kecomo/app/readers/search_meals.rb @ line 27 SearchMeals#by_text:

     [1;34m6[0m: [32mdef[0m [1;34mby_text[0m
     [1;34m7[0m:   results = [1;34;4mPgSearch[0m.multisearch(@params[[33m:searchquery[0m])
     [1;34m8[0m:   meals = [];
     [1;34m9[0m:   [32munless[0m results.nil?
    [1;34m10[0m:     all_results_array = []
    [1;34m11[0m:     results.each [32mdo[0m |result|
    [1;34m12[0m:       [32mif[0m result.searchable_type == [31m[1;31m"[0m[31mRestaurant[1;31m"[0m[31m[0m
    [1;34m13[0m:         resto = result.searchable
    [1;34m14[0m:         all_results_array << resto.meals
    [1;34m15[0m:       [32melsif[0m result.searchable_type == [31m[1;31m"[0m[31mCategory[1;31m"[0m[31m[0m
    [1;34m16[0m:         catego = result.searchable
    [1;34m17[0m:         all_results_array << catego.meals
    [1;34m18[0m:       [32melsif[0m result.searchable_type == [31m[1;31m"[0m[31mMeal[1;31m"[0m[31m[0m
    [1;34m19[0m:         meal = result.searchable
    [1;34m20[0m:         all_results_array << meal
    [1;34m21[0m:       [32mend[0m
    [1;34m22[0m:       flattened_array = all_results_array.flatten
    [1;34m23[0m:       [1;34m# sorted_array = flattened_array.sort_by { |meal| meal.awards.count }[0m
    [1;34m24[0m:       [1;34m# @meals = sorted_array.reverse![0m
    [1;34m25[0m:       sorted_array = flattened_array.sort_by { |meal| meal.awards.count }
    [1;34m26[0m:       binding.pry
 => [1;34m27[0m:       meals = sorted_array.reverse!.uniq
    [1;34m28[0m:     [32mend[0m
    [1;34m29[0m:   [32mend[0m
    [1;34m30[0m:   meals
    [1;34m31[0m: [32mend[0m

