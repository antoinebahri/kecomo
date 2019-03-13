# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'
require "httparty"

puts "Destroying all restaurants..."
Restaurant.destroy_all

url = "https://api.foursquare.com/v2/venues/explore?client_id=#{ENV["FOURSQUARE_CLIENT_ID"]}&client_secret=#{ENV["FOURSQUARE_SECRET_ID"]}&v=20180323&near=barcelona&query=restaurants&limit=50"

places_serialized = HTTParty.get(url).body
places_list = JSON.parse(places_serialized)

puts "Creating restaurants..."
r = 0
places_list["response"]["groups"][0]["items"].each do |place|
  url_photo = "https://api.foursquare.com/v2/venues/#{place["venue"]["id"]}/photos?client_id=#{ENV["FOURSQUARE_CLIENT_ID"]}&client_secret=#{ENV["FOURSQUARE_SECRET_ID"]}&v=20180323"

  photo_serialized = HTTParty.get(url_photo).body
  # open(url_photo).read
  photo_json = JSON.parse(photo_serialized)

  resto = Restaurant.create!(
    name: place["venue"]["name"],
    address: place["venue"]["location"]["address"],
    city: place["venue"]["location"]["city"],
    restaurant_category: place["venue"]["categories"][0]["name"],
    longitude: place["venue"]["location"]["lng"],
    latitude: place["venue"]["location"]["lat"]
  )
  if !photo_json["meta"].keys.include?("errorType")
    resto.picture = "#{photo_json["response"]["photos"]["items"][0]["prefix"]}500x500#{photo_json["response"]["photos"]["items"][0]["suffix"]}"
    resto.save
  end
  r = r + 1
end

# Meals categories have been created using the website bettycroker.com

puts "Destroying all meal categories.."
Category.destroy_all

meal_categories = ["Dessert", "Cookie", "Cupcake", "Salad", "French fries", "Burger", "Brownie", "Cheesecake", "Muffin", "Croissant", "Ice cream", "Chili", "Cinnamon rolls", "Garlic bread", "Bread", "Coffee", "Tea", "Crepe", "Waffle", "Meatloaf", "Pasta", "Risotto", "Ravioli", "Chicken", "Chicken wings", "Soup", "Stew", "Sandwich", "Naan", "Curry", "Pad thai", "Wok", "Egg", "Hot dog", "Tapas", "Cocktail", "Sushi", "Poke bowl",]

puts "Creating meal categories..."
c = 0
meal_categories.each do |category|
  Category.create!(name: category)
  c = c+ + 1
end

puts "#{r} restaurants have been created"
puts "#{c} meal categories have been created"

# ======= Previous seed


# puts 'Deleting seeds...'
# Award.delete_all
# Meal.delete_all
# Category.delete_all
# Restaurant.delete_all

# puts "Creating empty arrays"
# user_index_array = []
# cat_index_array = []
# rest_index_array = []
# meal_index_array = []
# award_index_array = []

# puts 'Creating categories...'
#   Category.create(name: 'Burger');
#   Category.create(name: 'Pizza');
#   Category.create(name: 'Noodles');
# puts 'Done'

# puts 'Seeding empty array of categories with their indices'
# Category.all.each do |cat|
#   cat_index_array << cat.id
# end

# puts 'Creating restaurants...'
#   Restaurant.create(name: 'Bacoa', address: 'Rambla 123', city: 'Barcelona', restaurant_category: 'American', description: 'Dope');
#   Restaurant.create(name: 'Timesburg', address: 'Rambla 456', city: 'Barcelona', restaurant_category: 'American', description: 'Cool');
#   Restaurant.create(name: 'McDonalds', address: 'Rambla 789', city: 'Barcelona', restaurant_category: 'American', description: 'Ass');
# puts 'Done'

# puts 'Seeding empty array of restaurants with their indices'
# Restaurant.all.each do |restaurant|
#   rest_index_array << restaurant.id
# end

# puts 'Creating meals...'
#   Meal.create(name: 'Chorizo Burger', description: 'Amazing', restaurant_id: rest_index_array[0], category_id: cat_index_array[0]);
#   Meal.create(name: 'Picanha Burger', description: 'Great', restaurant_id: rest_index_array[1], category_id: cat_index_array[0]);
#   Meal.create(name: 'Big Mac', description: 'Plastic', restaurant_id: rest_index_array[2], category_id: cat_index_array[0]);
# puts 'Done'

# puts 'Seeding empty array of meals with their indices'
# Meal.all.each do |meal|
#   meal_index_array << meal.id
# end

# puts 'Creating users...'
#   User.create(first_name: 'Juan', last_name: 'Goycochea', email: 'jgoyco@gmail.com', password: '123456');
#   User.create(first_name: 'Alberto', last_name: 'Goycochea', email: 'agoyco@gmail.com', password: '123456');
#   User.create(first_name: 'Luis', last_name: 'Goycochea', email: 'lgoyco@gmail.com', password: '123456');
# puts 'Done'

# puts 'Seeding empty array of users with their indices'
# User.all.each do |user|
#   user_index_array << user.id
# end

# puts 'Creating awards...'
#   Award.create(review: 'Boom', meal_id: meal_index_array[0], category_id: cat_index_array[0], user_id: user_index_array[0]);
#   Award.create(review: 'Boom', meal_id: meal_index_array[0], category_id: cat_index_array[0], user_id: user_index_array[0]);
#   Award.create(review: 'Boom', meal_id: meal_index_array[0], category_id: cat_index_array[0], user_id: user_index_array[0]);
#   Award.create(review: 'Boo Yah', meal_id: meal_index_array[1], category_id: cat_index_array[0], user_id: user_index_array[1]);
#   Award.create(review: 'Boo Yah', meal_id: meal_index_array[1], category_id: cat_index_array[0], user_id: user_index_array[1]);
#   Award.create(review: 'Bullshit', meal_id: meal_index_array[2], category_id: cat_index_array[0], user_id: user_index_array[2]);
# puts 'Done'

