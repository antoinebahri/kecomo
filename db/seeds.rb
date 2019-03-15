# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'faker'
require 'open-uri'
require "httparty"

puts "-----------------------------------"
puts "Destroying all users"
User.destroy_all
puts "creating team-member users in format: d.penev@lewagon.com, pass: 123123"
User.create(email: "a.bahri@lewagon.com", password: "123123")
User.create(email: "f.ordeig@lewagon.com", password: "123123")
User.create(email: "n.michel@lewagon.com", password: "123123")
User.create(email: "d.penev@lewagon.com", password: "123123")
puts "Team users created"
puts "-----------------------------------"
# puts "-----------------------------------"
# puts "creating 30 faker profiles"
# 30.times do
# User.create(email: Faker::Internet.email, password: "123123")
# puts "30 faker profiles created"
# end
# puts "-----------------------------------"
puts "-----------------------------------"
puts "creating 30 real profiles"
puts "Creating users..."
30.times do
  url = 'https://randomuser.me/api/'
  users_serialized = HTTParty.get(url).body
  users_list = JSON.parse(users_serialized)
  user = User.create(
    first_name: users_list["results"][0]["name"]["first"].capitalize!,
    last_name: users_list["results"][0]["name"]["last"].capitalize!,
    email: users_list["results"][0]["email"],
    password: "123123",
    picture: users_list["results"][0]["picture"]["large"],
  )
end
puts "-----------------------------------"


puts "-----------------------------------"
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
puts "-----------------------------------"
# Meals categories have been created using the website bettycroker.com
puts "-----------------------------------"
puts "Destroying all meal categories.."
Category.destroy_all
meal_categories = ["Dessert", "Cookie", "Cupcake", "Salad", "French Fries", "Burger", "Brownie", "Muffin", "Croissant", "Ice Cream", "Cinnamon Roll", "Bread", "Pie", "Cake", "Coffee", "Tea", "Pasta", "Chicken", "Sandwich", "Curry", "Wok", "Egg", "Hot Dog", "Tapas", "Cocktail", "Sushi", "Taco", "Noodles", "Meat", "Donut", "Pizza"]
puts "Creating meal categories..."
c = 0
meal_categories.each do |category|
  Category.create!(name: category, icon: "#{category.downcase.tr(" ", "_")}.png")
  c = c + 1
end

puts "#{r} restaurants have been created"
puts "#{c} meal categories have been created"

puts "-----------------------------------"
puts "-----------------------------------"
puts "Destroying all meals"
Meal.destroy_all

# puts "Creating 200 fake new meals"
# meal_counter = 1
# 200.times do
#   meal = Meal.new(name: "meal N:#{meal_counter}")
#   meal_counter += 1
#   meal.restaurant = Restaurant.all.sample
#   meal.category = Category.all.sample
#   meal.picture = "https://www.tasteofhome.com/wp-content/uploads/2017/10/exps28800_UG143377D12_18_1b_RMS-696x696.jpg"

#   meal.save!
# end
# puts "200 fake meals created"

puts "creating real meals data"
meal1 = Meal.new(name: "Pizza Stracciatella")
meal1.restaurant = Restaurant.find(44)
meal1.category = Category.find_by(name: "Pizza")
meal1.picture = "stracciatella-parking-pizza.jpg"
meal1.save!

meal2 = Meal.new(name: "Pizza Sobrasada")
meal2.restaurant = Restaurant.find(44)
meal2.category = Category.find_by(name: "Pizza")
meal2.picture = "sobrasada-parking-pizza.jpg"
meal2.save!

meal3 = Meal.new(name: "Suiza Burger")
meal3.restaurant = Restaurant.find(49)
meal3.category = Category.find_by(name: "Burger")
meal3.picture = "suiza-bacoa-universitat.jpg"
meal3.save!

meal4 = Meal.new(name: "Australiana Burger")
meal4.restaurant = Restaurant.find(49)
meal4.category = Category.find_by(name: "Burger")
meal4.picture = "australiana-bacoa-universitat.jpg"
meal4.save!

meal5 = Meal.new(name: "Pho Pia Kai")
meal5.restaurant = Restaurant.find(26)
meal5.category = Category.find_by(name: "Noodles")
meal5.picture = "pho-pia-kai-el-petit-bangkok.jpg"
meal5.save!

meal6 = Meal.new(name: "Pho Pia Kung")
meal6.restaurant = Restaurant.find(26)
meal6.category = Category.find_by(name: "Noodles")
meal6.picture = "pho-pia-kung-el-petit-bangkok.jpeg"
meal6.save!

meal7 = Meal.new(name: "Pizza Rimini")
meal7.restaurant = Restaurant.find(10)
meal7.category = Category.find_by(name: "Pizza")
meal7.picture = "pizza-rimini-pizza-circus.jpeg"
meal7.save!

meal8 = Meal.new(name: "Pizza Octaviana")
meal8.restaurant = Restaurant.find(10)
meal8.category = Category.find_by(name: "Pizza")
meal8.picture = "pizza-octaviana-pizza-circus.jpeg"
meal8.save!

meal9 = Meal.new(name: "Pizza Calabrese")
meal9.restaurant = Restaurant.find(10)
meal9.category = Category.find_by(name: "Pizza")
meal9.picture = "pizza-calabrese-pizza-circus.jpeg"
meal9.save!

meal10 = Meal.new(name: "Pizza Garmona")
meal10.restaurant = Restaurant.find(1)
meal10.category = Category.find_by(name: "Pizza")
meal10.picture = "garmona-parking-pizza.jpg"
meal10.save!

meal11 = Meal.new(name: "Pizza Especial")
meal11.restaurant = Restaurant.find(1)
meal11.category = Category.find_by(name: "Pizza")
meal11.picture = "especial-parking-pizza.jpg"
meal11.save!

meal12 = Meal.new(name: "Pizza Senna")
meal12.restaurant = Restaurant.find(44)
meal12.category = Category.find_by(name: "Pizza")
meal12.picture = "senna-parking-pizza.jpg"
meal12.save!

meal13 = Meal.new(name: "Pizza Nona")
meal13.restaurant = Restaurant.find(32)
meal13.category = Category.find_by(name: "Pizza")
meal13.picture = "nona-can-pizza-prat.jpg"
meal13.save!

meal14 = Meal.new(name: "Pizza Canta")
meal14.restaurant = Restaurant.find(32)
meal14.category = Category.find_by(name: "Pizza")
meal14.picture = "canta-can-pizza-prat.jpg"
meal14.save!

meal15 = Meal.new(name: "Pizza Edensa")
meal15.restaurant = Restaurant.find(32)
meal15.category = Category.find_by(name: "Pizza")
meal15.picture = "edensa-can-pizza-prat.jpg"
meal15.save!

meal16 = Meal.new(name: "Patatas Bravas")
meal16.restaurant = Restaurant.find(39)
meal16.category = Category.find_by(name: "Tapas")
meal16.picture = "patatas-bravas-39.jpeg"
meal16.save!

meal17 = Meal.new(name: "Pulpo Gallego")
meal17.restaurant = Restaurant.find(39)
meal17.category = Category.find_by(name: "Tapas")
meal17.picture = "pulpo-gallego-39.jpg"
meal17.save!

meal18 = Meal.new(name: "Croquette de Pollo")
meal18.restaurant = Restaurant.find(39)
meal18.category = Category.find_by(name: "Tapas")
meal18.picture = "croquette-de-pollo-39.jpeg"
meal18.save!

meal19 = Meal.new(name: "Tortilla Espanola")
meal19.restaurant = Restaurant.find(39)
meal19.category = Category.find_by(name: "Tapas")
meal19.picture = "tortilla-espanola-39.jpeg"
meal19.save!

meal20 = Meal.new(name: "Patatas Bravas")
meal20.restaurant = Restaurant.find(40)
meal20.category = Category.find_by(name: "Tapas")
meal20.picture = "patatas-bravas-40.jpeg"
meal20.save!

meal21 = Meal.new(name: "Pulpo Gallego")
meal21.restaurant = Restaurant.find(40)
meal21.category = Category.find_by(name: "Tapas")
meal21.picture = "pulpo-gallego-40.jpg"
meal21.save!

meal22 = Meal.new(name: "Croquette de Pollo")
meal22.restaurant = Restaurant.find(40)
meal22.category = Category.find_by(name: "Tapas")
meal22.picture = "croquette-de-pollo-40.jpg"
meal22.save!

meal23 = Meal.new(name: "Tortilla Espanola")
meal23.restaurant = Restaurant.find(40)
meal23.category = Category.find_by(name: "Tapas")
meal23.picture = "tortilla-espanola-40.jpg"
meal23.save!

meal24 = Meal.new(name: "Patatas Bravas")
meal24.restaurant = Restaurant.find(43)
meal24.category = Category.find_by(name: "Tapas")
meal24.picture = "patatas-bravas-43.jpeg"
meal24.save!

meal25 = Meal.new(name: "Pulpo Gallego")
meal25.restaurant = Restaurant.find(43)
meal25.category = Category.find_by(name: "Tapas")
meal25.picture = "pulpo-gallego-43.jpg"
meal25.save!

meal26 = Meal.new(name: "Croquette de Pollo")
meal26.restaurant = Restaurant.find(43)
meal26.category = Category.find_by(name: "Tapas")
meal26.picture = "croquette-de-pollo-43.jpg"
meal26.save!

meal27 = Meal.new(name: "Tortilla Espanola")
meal27.restaurant = Restaurant.find(43)
meal27.category = Category.find_by(name: "Tapas")
meal27.picture = "tortilla-espanola-43.jpg"
meal27.save!

meal28 = Meal.new(name: "Patatas Bravas")
meal28.restaurant = Restaurant.find(34)
meal28.category = Category.find_by(name: "Tapas")
meal28.picture = "patatas-bravas-34.jpg"
meal28.save!

meal29 = Meal.new(name: "Pulpo Gallego")
meal29.restaurant = Restaurant.find(34)
meal29.category = Category.find_by(name: "Tapas")
meal29.picture = "pulpo-gallego-34.jpg"
meal29.save!

meal30 = Meal.new(name: "Croquette de Pollo")
meal30.restaurant = Restaurant.find(34)
meal30.category = Category.find_by(name: "Tapas")
meal30.picture = "croquette-de-pollo-34.jpg"
meal30.save!

meal31 = Meal.new(name: "Tortilla Espanola")
meal31.restaurant = Restaurant.find(34)
meal31.category = Category.find_by(name: "Tapas")
meal31.picture = "tortilla-espanola-34.jpg"
meal31.save!

puts "-----------------------------------"
puts "-----------------------------------"
puts "Destroying all awards"
Award.destroy_all
puts "Creating 800 awards"
800.times do
  award = Award.new
  award.meal = Meal.all.sample
  award.user = User.all.sample
  award.review = Faker::Restaurant.review
  award.save!
end
puts '800 awards with faker reviews distributed'
puts "-----------------------------------"
puts "-----------------------------------"


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
