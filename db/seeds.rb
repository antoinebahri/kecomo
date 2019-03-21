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
User.create(email: "a.bahri@lewagon.com", password: "123123", first_name: "Antoine", last_name: "Bahri")
User.create(email: "f.ordeig@lewagon.com", password: "123123", first_name: "Francesc", last_name: "Ordeig")
User.create(email: "ngilmichel@lewagon.com", password: "123123", first_name: "Nico", last_name: "Michel")
User.create(email: "d.penev@lewagon.com", password: "123123", first_name: "Doncho", last_name: "Penev")
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
puts "creating 400 real profiles"
puts "Creating users..."
400.times do
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
puts "400 other real profiles created"


puts "-----------------------------------"
puts "Destroying all restaurants..."
Restaurant.destroy_all

# url = "https://api.foursquare.com/v2/venues/explore?client_id=#{ENV["FOURSQUARE_CLIENT_ID"]}&client_secret=#{ENV["FOURSQUARE_SECRET_ID"]}&v=20180323&near=barcelona&query=restaurants&limit=50"

# places_serialized = HTTParty.get(url).body
# places_list = JSON.parse(places_serialized)

puts "Creating restaurants..."
puts "5 burger joints, 5 pizzeria"

resto_parking_pizza = Restaurant.create!(
  name: "Parking Pizza",
  address: "Barcelona, C. Londres, 98",
  city: "Barcelona",
  restaurant_category: "Pizza Place",
  longitude: 0.4024626,
  latitude: 40.3695197,
)
resto_parking_pizza.picture = "parking-pizza.jpg"
resto_parking_pizza.save!

resto_circus_pizza = Restaurant.create!(
  name: "Pizza Circus",
  address: "Barcelona, Carrer Nou de la Rambla 40",
  city: "Barcelona",
  restaurant_category: "Pizza Place",
  longitude: 2.1731457,
  latitude: 41.378101,
)
resto_circus_pizza.picture = "pizza-circus.jpg"
resto_circus_pizza.save!

resto_can_pizza_prat = Restaurant.create!(
  name: "Can Pizza Prat",
  address: "Barcelona, Enric Morera 38",
  city: "Barcelona",
  restaurant_category: "Pizza Place",
  longitude: 2.24709014307571,
  latitude: 41.46152525,
)
resto_can_pizza_prat.picture = "canta-can-pizza-prat.jpg.jpg"
resto_can_pizza_prat.save!

resto_il_capriccio = Restaurant.create!(
  name: "Il Capriccio",
  address: "Barcelona, Carrer de Sant Antoni Maria Claret, 125, 08025",
  city: "Barcelona",
  restaurant_category: "Pizza Place",
  longitude: 2.171625,
  latitude: 41.409281,
)
resto_il_capriccio.picture = "il-capriccio.jpg"
resto_il_capriccio.save!

resto_per_bacco = Restaurant.create!(
  name: "PerBacco!",
  address: "Barcelona, Avenida Diagonal, 339",
  city: "Barcelona",
  restaurant_category: "Pizza Place",
  longitude: 2.167443,
  latitude: 41.398330,
)
resto_per_bacco.picture = "per-bacco.jpg"
resto_per_bacco.save!

resto_bacoa = Restaurant.create!(
  name: "Bacoa Universitat",
  address: "Barcelona, Calle Judici, 15, 08003",
  city: "Barcelona",
  restaurant_category: "Burger Joint",
  longitude: 2.167182,
  latitude: 41.387099,
)
resto_bacoa.picture = "bacoa-burgers.jpg"
resto_bacoa.save!

resto_national_burger = Restaurant.create!(
  name: "National Burger",
  address: "Barcelona ,Carrer Nou de la Rambla 22, 08001",
  city: "Barcelona",
  restaurant_category: "Burger Joint",
  longitude: 2.173581,
  latitude: 41.378551,
)
resto_national_burger.picture = "national-burger.jpg"
resto_national_burger.save!

resto_makamaka = Restaurant.create!(
  name: "Makamaka",
  address: "Barcelona ,Passeig de Joan de Borbo, 76, 08039",
  city: "Barcelona",
  restaurant_category: "Burger Joint",
  longitude: 2.188570,
  latitude: 41.375745,
)
resto_makamaka.picture = "makamaka.jpg"
resto_makamaka.save!

resto_la_central = Restaurant.create!(
  name: "La Central",
  address: "Barcelona, Via Laietana, 45, 08002",
  city: "Barcelona",
  restaurant_category: "Burger Joint",
  longitude: 2.174943,
  latitude: 41.386691,
)
resto_la_central.picture = "la-central.jpeg"
resto_la_central.save!

resto_la_caleta = Restaurant.create!(
  name: "La Caleta Burger",
  address: "Barcelona, Rambla del Raval 18, 08001",
  city: "Barcelona",
  restaurant_category: "Burger Joint",
  longitude: 2.169497,
  latitude: 41.378137,
)
resto_la_caleta.picture = "la-caleta-burger.jpg"
resto_la_caleta.save!

# r = 0
# places_list["response"]["groups"][0]["items"].each do |place|
#   url_photo = "https://api.foursquare.com/v2/venues/#{place["venue"]["id"]}/photos?client_id=#{ENV["FOURSQUARE_CLIENT_ID"]}&client_secret=#{ENV["FOURSQUARE_SECRET_ID"]}&v=20180323"

#   photo_serialized = HTTParty.get(url_photo).body
#   # open(url_photo).read
#   photo_json = JSON.parse(photo_serialized)


#     resto = Restaurant.create!(
#     name: place["venue"]["name"],
#     address: place["venue"]["location"]["address"],
#     city: place["venue"]["location"]["city"],
#     restaurant_category: place["venue"]["categories"][0]["name"],
#     longitude: place["venue"]["location"]["lng"],
#     latitude: place["venue"]["location"]["lat"]
#   )

#   if !photo_json["meta"].keys.include?("errorType")
#     resto.picture = "#{photo_json["response"]["photos"]["items"][0]["prefix"]}500x500#{photo_json["response"]["photos"]["items"][0]["suffix"]}"
#     resto.save
#   end
#   r = r + 1
# end
puts "10 restaurants created"
puts "-----------------------------------"
# Meals categories have been created using the website bettycroker.com
puts "-----------------------------------"
puts "Destroying all meal categories.."
Category.destroy_all
meal_categories = ["Dessert", "Cookie", "Cupcake", "Salad", "French Fries", "Burger", "Brownie", "Muffin", "Croissant", "Ice Cream", "Cinnamon Roll", "Bread", "Pie", "Cake", "Coffee", "Tea", "Pasta", "Chicken", "Sandwich", "Curry", "Wok", "Egg", "Hot Dog", "Tapas", "Cocktail", "Sushi", "Taco", "Noodles", "Meat", "Donut", "Pizza"]
meal_categories = meal_categories.sort
puts "Creating meal categories..."
c = 0
meal_categories.each do |category|
  Category.create!(name: category, icon: "#{category.downcase.tr(" ", "_")}.png")
  c = c + 1
end

# puts "#{r} restaurants have been created"
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
puts "creating 95 real meals..."

# puts "creating real meals data"
meal1 = Meal.new(name: "Pizza Stracciatella")
meal1.restaurant = Restaurant.find(1)
meal1.category = Category.find_by(name: "Pizza")
meal1.picture = "stracciatella-parking-pizza.jpg"
meal1.save!

meal2 = Meal.new(name: "Pizza Sobrasada")
meal2.restaurant = Restaurant.find(1)
meal2.category = Category.find_by(name: "Pizza")
meal2.picture = "sobrasada-parking-pizza.jpg"
meal2.save!

meal7 = Meal.new(name: "Pizza Rimini")
meal7.restaurant = Restaurant.find(1)
meal7.category = Category.find_by(name: "Pizza")
meal7.picture = "pizza-rimini-pizza-circus.jpeg"
meal7.save!

meal8 = Meal.new(name: "Pizza Octaviana")
meal8.restaurant = Restaurant.find(1)
meal8.category = Category.find_by(name: "Pizza")
meal8.picture = "pizza-octaviana-pizza-circus.jpeg"
meal8.save!

meal9 = Meal.new(name: "Pizza Calabrese")
meal9.restaurant = Restaurant.find(1)
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
meal12.restaurant = Restaurant.find(1)
meal12.category = Category.find_by(name: "Pizza")
meal12.picture = "senna-parking-pizza.jpg"
meal12.save!

meal13 = Meal.new(name: "Pizza Nona")
meal13.restaurant = Restaurant.find(1)
meal13.category = Category.find_by(name: "Pizza")
meal13.picture = "nona-can-pizza-prat.jpg"
meal13.save!

meal14 = Meal.new(name: "Pizza Canta")
meal14.restaurant = Restaurant.find(1)
meal14.category = Category.find_by(name: "Pizza")
meal14.picture = "canta-can-pizza-prat.jpg"
meal14.save!

meal15 = Meal.new(name: "Pizza Edensa")
meal15.restaurant = Restaurant.find(1)
meal15.category = Category.find_by(name: "Pizza")
meal15.picture = "edensa-can-pizza-prat.jpg"
meal15.save!

meal16 = Meal.new(name: "Pizza Valencia")
meal16.restaurant = Restaurant.find(2)
meal16.category = Category.find_by(name: "Pizza")
meal16.picture = "pizza-2.jpg"
meal16.save!

meal17 = Meal.new(name: "Pizza Bretana")
meal17.restaurant = Restaurant.find(2)
meal17.category = Category.find_by(name: "Pizza")
meal17.picture = "pizza-3.jpeg"
meal17.save!

meal18 = Meal.new(name: "Pizza Brava")
meal18.restaurant = Restaurant.find(2)
meal18.category = Category.find_by(name: "Pizza")
meal18.picture = "pizza-4.jpg"
meal18.save!

meal19 = Meal.new(name: "Pizza Celebra")
meal19.restaurant = Restaurant.find(2)
meal19.category = Category.find_by(name: "Pizza")
meal19.picture = "pizza-5.jpg"
meal19.save!

meal20 = Meal.new(name: "Pizza Rugani")
meal20.restaurant = Restaurant.find(2)
meal20.category = Category.find_by(name: "Pizza")
meal20.picture = "pizza-6.jpg"
meal20.save!

meal21 = Meal.new(name: "Pizza Lombarda")
meal21.restaurant = Restaurant.find(2)
meal21.category = Category.find_by(name: "Pizza")
meal21.picture = "pizza-7.jpeg"
meal21.save!

meal22 = Meal.new(name: "Pizza Brescia")
meal22.restaurant = Restaurant.find(2)
meal22.category = Category.find_by(name: "Pizza")
meal22.picture = "pizza-8.jpg"
meal22.save!

meal23 = Meal.new(name: "Pizza Gastronomica")
meal23.restaurant = Restaurant.find(2)
meal23.category = Category.find_by(name: "Pizza")
meal23.picture = "pizza-9.jpg"
meal23.save!

meal24 = Meal.new(name: "Pizza Classica")
meal24.restaurant = Restaurant.find(3)
meal24.category = Category.find_by(name: "Pizza")
meal24.picture = "pizza-11.jpg"
meal24.save!

meal25 = Meal.new(name: "Pizza Prono")
meal25.restaurant = Restaurant.find(3)
meal25.category = Category.find_by(name: "Pizza")
meal25.picture = "pizza-12.jpg"
meal25.save!

meal26 = Meal.new(name: "Pizza Pannata")
meal26.restaurant = Restaurant.find(2)
meal26.category = Category.find_by(name: "Pizza")
meal26.picture = "pizza-10.jpg"
meal26.save!

meal27 = Meal.new(name: "Pizza Adele")
meal27.restaurant = Restaurant.find(2)
meal27.category = Category.find_by(name: "Pizza")
meal27.picture = "pizza-1.jpg"
meal27.save!

meal28 = Meal.new(name: "Pizza Selena")
meal28.restaurant = Restaurant.find(3)
meal28.category = Category.find_by(name: "Pizza")
meal28.picture = "pizza-13.jpg"
meal28.save!

meal29 = Meal.new(name: "Pizza Maria")
meal29.restaurant = Restaurant.find(3)
meal29.category = Category.find_by(name: "Pizza")
meal29.picture = "pizza-14.jpg"
meal29.save!

meal30 = Meal.new(name: "Pizza Valeria")
meal30.restaurant = Restaurant.find(3)
meal30.category = Category.find_by(name: "Pizza")
meal30.picture = "pizza-15.jpg"
meal30.save!

meal31 = Meal.new(name: "Pizza Nerola")
meal31.restaurant = Restaurant.find(3)
meal31.category = Category.find_by(name: "Pizza")
meal31.picture = "pizza-16.jpg"
meal31.save!

meal32 = Meal.new(name: "Pizza Monza")
meal32.restaurant = Restaurant.find(3)
meal32.category = Category.find_by(name: "Pizza")
meal32.picture = "pizza-17.jpg"
meal32.save!

meal33 = Meal.new(name: "Pizza Ademola")
meal33.restaurant = Restaurant.find(3)
meal33.category = Category.find_by(name: "Pizza")
meal33.picture = "pizza-18.jpg"
meal33.save!

meal34 = Meal.new(name: "Pizza Helena")
meal34.restaurant = Restaurant.find(3)
meal34.category = Category.find_by(name: "Pizza")
meal34.picture = "pizza-19.jpg"
meal34.save!

meal35 = Meal.new(name: "Pizza Palio")
meal35.restaurant = Restaurant.find(3)
meal35.category = Category.find_by(name: "Pizza")
meal35.picture = "pizza-20.jpg"
meal35.save!

meal36 = Meal.new(name: "Pizza Quatro")
meal36.restaurant = Restaurant.find(3)
meal36.category = Category.find_by(name: "Pizza")
meal36.picture = "pizza-21.jpg"
meal36.save!

meal37 = Meal.new(name: "Pizza Linea")
meal37.restaurant = Restaurant.find(4)
meal37.category = Category.find_by(name: "Pizza")
meal37.picture = "pizza-22.jpg"
meal37.save!

meal38 = Meal.new(name: "Pizza Adina")
meal38.restaurant = Restaurant.find(4)
meal38.category = Category.find_by(name: "Pizza")
meal38.picture = "pizza-23.jpeg"
meal38.save!

meal39 = Meal.new(name: "Pizza Bonnita")
meal39.restaurant = Restaurant.find(4)
meal39.category = Category.find_by(name: "Pizza")
meal39.picture = "pizza-24.jpg"
meal39.save!

meal40 = Meal.new(name: "Pizza Carlotta")
meal40.restaurant = Restaurant.find(4)
meal40.category = Category.find_by(name: "Pizza")
meal40.picture = "pizza-25.jpg"
meal40.save!

meal41 = Meal.new(name: "Pizza Gracia")
meal41.restaurant = Restaurant.find(4)
meal41.category = Category.find_by(name: "Pizza")
meal41.picture = "pizza-26.png"
meal41.save!

meal42 = Meal.new(name: "Pizza Xample")
meal42.restaurant = Restaurant.find(4)
meal42.category = Category.find_by(name: "Pizza")
meal42.picture = "pizza-27.jpg"
meal42.save!

meal43 = Meal.new(name: "Pizza Catala")
meal43.restaurant = Restaurant.find(4)
meal43.category = Category.find_by(name: "Pizza")
meal43.picture = "pizza-28.jpg"
meal43.save!

meal44 = Meal.new(name: "Pizza Nuestra")
meal44.restaurant = Restaurant.find(4)
meal44.category = Category.find_by(name: "Pizza")
meal44.picture = "pizza-29.jpg"
meal44.save!


meal45 = Meal.new(name: "Pizza Trada")
meal45.restaurant = Restaurant.find(4)
meal45.category = Category.find_by(name: "Pizza")
meal45.picture = "pizza-30.png"
meal45.save!

meal46 = Meal.new(name: "Pizza Natural")
meal46.restaurant = Restaurant.find(5)
meal46.category = Category.find_by(name: "Pizza")
meal46.picture = "pizza-31.jpeg"
meal46.save!

meal47 = Meal.new(name: "Pizza Catto")
meal47.restaurant = Restaurant.find(5)
meal47.category = Category.find_by(name: "Pizza")
meal47.picture = "pizza-32.jpg"
meal47.save!

meal48 = Meal.new(name: "Pizza Verta")
meal48.restaurant = Restaurant.find(5)
meal48.category = Category.find_by(name: "Pizza")
meal48.picture = "pizza-33.jpg"
meal48.save!

meal49 = Meal.new(name: "Pizza Leandra")
meal49.restaurant = Restaurant.find(5)
meal49.category = Category.find_by(name: "Pizza")
meal49.picture = "pizza-34.jpg"
meal49.save!

meal50 = Meal.new(name: "Pizza Beccio")
meal50.restaurant = Restaurant.find(5)
meal50.category = Category.find_by(name: "Pizza")
meal50.picture = "pizza-35.jpg"
meal50.save!

meal51 = Meal.new(name: "Pizza Carmella")
meal51.restaurant = Restaurant.find(5)
meal51.category = Category.find_by(name: "Pizza")
meal51.picture = "pizza-36.jpg"
meal51.save!

meal52 = Meal.new(name: "Pizza Campa")
meal52.restaurant = Restaurant.find(5)
meal52.category = Category.find_by(name: "Pizza")
meal52.picture = "pizza-37.jpg"
meal52.save!

meal53 = Meal.new(name: "Pizza Sestra")
meal53.restaurant = Restaurant.find(5)
meal53.category = Category.find_by(name: "Pizza")
meal53.picture = "pizza-38.jpg"
meal53.save!

meal54 = Meal.new(name: "Pizza Manuela")
meal54.restaurant = Restaurant.find(5)
meal54.category = Category.find_by(name: "Pizza")
meal54.picture = "pizza-39.jpg"
meal54.save!

meal55 = Meal.new(name: "Pizza Arretta")
meal55.restaurant = Restaurant.find(5)
meal55.category = Category.find_by(name: "Pizza")
meal55.picture = "pizza-40.jpg"
meal55.save!

meal56 = Meal.new(name: "Brava Burger")
meal56.restaurant = Restaurant.find(6)
meal56.category = Category.find_by(name: "Burger")
meal56.picture = "burger-1.jpg"
meal56.save!

meal3 = Meal.new(name: "Suiza Burger")
meal3.restaurant = Restaurant.find(6)
meal3.category = Category.find_by(name: "Burger")
meal3.picture = "suiza-bacoa-universitat.jpg"
meal3.save!

meal4 = Meal.new(name: "Australiana Burger")
meal4.restaurant = Restaurant.find(6)
meal4.category = Category.find_by(name: "Burger")
meal4.picture = "australiana-bacoa-universitat.jpg"
meal4.save!

meal57 = Meal.new(name: "Resta Burger")
meal57.restaurant = Restaurant.find(6)
meal57.category = Category.find_by(name: "Burger")
meal57.picture = "burger-2.jpg"
meal57.save!

meal58 = Meal.new(name: "Besta Burger")
meal58.restaurant = Restaurant.find(6)
meal58.category = Category.find_by(name: "Burger")
meal58.picture = "burger-3.jpg"
meal58.save!

meal59 = Meal.new(name: "Sudona Burger")
meal59.restaurant = Restaurant.find(6)
meal59.category = Category.find_by(name: "Burger")
meal59.picture = "burger-4.jpg"
meal59.save!

meal60 = Meal.new(name: "Pongo Burger")
meal60.restaurant = Restaurant.find(6)
meal60.category = Category.find_by(name: "Burger")
meal60.picture = "burger-6.jpg"
meal60.save!

meal61 = Meal.new(name: "Classic Burger")
meal61.restaurant = Restaurant.find(6)
meal61.category = Category.find_by(name: "Burger")
meal61.picture = "burger-7.jpg"
meal61.save!

meal62 = Meal.new(name: "Cheese Burger")
meal62.restaurant = Restaurant.find(6)
meal62.category = Category.find_by(name: "Burger")
meal62.picture = "burger-8.jpg"
meal62.save!

meal63 = Meal.new(name: "Quira Burger")
meal63.restaurant = Restaurant.find(6)
meal63.category = Category.find_by(name: "Burger")
meal63.picture = "burger-9.jpg"
meal63.save!

meal64 = Meal.new(name: "Big Grand Burger")
meal64.restaurant = Restaurant.find(7)
meal64.category = Category.find_by(name: "Burger")
meal64.picture = "burger-10.jpg"
meal64.save!

meal65 = Meal.new(name: "Nulo Burger")
meal65.restaurant = Restaurant.find(7)
meal65.category = Category.find_by(name: "Burger")
meal65.picture = "burger-11.jpg"
meal65.save!

meal66 = Meal.new(name: "Addonis Burger")
meal66.restaurant = Restaurant.find(7)
meal66.category = Category.find_by(name: "Burger")
meal66.picture = "burger-12.jpg"
meal66.save!

meal67 = Meal.new(name: "Colombo Burger")
meal67.restaurant = Restaurant.find(7)
meal67.category = Category.find_by(name: "Burger")
meal67.picture = "burger-13.jpg"
meal67.save!

meal68 = Meal.new(name: "Not-so-cheesy Burger")
meal68.restaurant = Restaurant.find(7)
meal68.category = Category.find_by(name: "Burger")
meal68.picture = "burger-14.jpg"
meal68.save!

meal69 = Meal.new(name: "Perfecto Burger")
meal69.restaurant = Restaurant.find(7)
meal69.category = Category.find_by(name: "Burger")
meal69.picture = "burger-15.jpg"
meal69.save!

meal70 = Meal.new(name: "Beeeef Burger")
meal70.restaurant = Restaurant.find(7)
meal70.category = Category.find_by(name: "Burger")
meal70.picture = "burger-16.jpg"
meal70.save!

meal71 = Meal.new(name: "Rambla Burger")
meal71.restaurant = Restaurant.find(7)
meal71.category = Category.find_by(name: "Burger")
meal71.picture = "burger-17.jpg"
meal71.save!

meal72 = Meal.new(name: "Gastronomico Burger")
meal72.restaurant = Restaurant.find(7)
meal72.category = Category.find_by(name: "Burger")
meal72.picture = "burger-18.jpg"
meal72.save!

meal73 = Meal.new(name: "Gusto Burger")
meal73.restaurant = Restaurant.find(7)
meal73.category = Category.find_by(name: "Burger")
meal73.picture = "burger-19.jpeg"
meal73.save!

meal74 = Meal.new(name: "El Burger del Chef")
meal74.restaurant = Restaurant.find(8)
meal74.category = Category.find_by(name: "Burger")
meal74.picture = "burger-20.jpg"
meal74.save!

meal75 = Meal.new(name: "America Burger")
meal75.restaurant = Restaurant.find(8)
meal75.category = Category.find_by(name: "Burger")
meal75.picture = "burger-21.jpeg"
meal75.save!

meal76 = Meal.new(name: "Brista Burger")
meal76.restaurant = Restaurant.find(8)
meal76.category = Category.find_by(name: "Burger")
meal76.picture = "burger-22.jpg"
meal76.save!

meal77 = Meal.new(name: "California Burger")
meal77.restaurant = Restaurant.find(8)
meal77.category = Category.find_by(name: "Burger")
meal77.picture = "burger-23.jpg"
meal77.save!

meal78 = Meal.new(name: "Costa Burger")
meal78.restaurant = Restaurant.find(8)
meal78.category = Category.find_by(name: "Burger")
meal78.picture = "burger-24.jpeg"
meal78.save!

meal79 = Meal.new(name: "Concorda Burger")
meal79.restaurant = Restaurant.find(8)
meal79.category = Category.find_by(name: "Burger")
meal79.picture = "burger-25.jpg"
meal79.save!

meal80 = Meal.new(name: "Numero Burger")
meal80.restaurant = Restaurant.find(8)
meal80.category = Category.find_by(name: "Burger")
meal80.picture = "burger-26.jpg"
meal80.save!

meal81 = Meal.new(name: "Destina Burger")
meal81.restaurant = Restaurant.find(8)
meal81.category = Category.find_by(name: "Burger")
meal81.picture = "burger-27.jpg"
meal81.save!

meal82 = Meal.new(name: "Presto Burger")
meal82.restaurant = Restaurant.find(9)
meal82.category = Category.find_by(name: "Burger")
meal82.picture = "burger-28.jpg"
meal82.save!

meal83 = Meal.new(name: "Grand Burger")
meal83.restaurant = Restaurant.find(9)
meal83.category = Category.find_by(name: "Burger")
meal83.picture = "burger-28.jpg"
meal83.save!

meal84 = Meal.new(name: "El Centro Burger")
meal84.restaurant = Restaurant.find(9)
meal84.category = Category.find_by(name: "Burger")
meal84.picture = "burger-29.jpg"
meal84.save!

meal85 = Meal.new(name: "Tango Burger")
meal85.restaurant = Restaurant.find(9)
meal85.category = Category.find_by(name: "Burger")
meal85.picture = "burger-30.jpg"
meal85.save!

meal86 = Meal.new(name: "Dulce Burger")
meal86.restaurant = Restaurant.find(9)
meal86.category = Category.find_by(name: "Burger")
meal86.picture = "burger-32.jpg"
meal86.save!

meal87 = Meal.new(name: "Muchissim Burger")
meal87.restaurant = Restaurant.find(9)
meal87.category = Category.find_by(name: "Burger")
meal87.picture = "burger-33.jpg"
meal87.save!

meal88 = Meal.new(name: "Zarrato Burger")
meal88.restaurant = Restaurant.find(9)
meal88.category = Category.find_by(name: "Burger")
meal88.picture = "burger-34.jpg"
meal88.save!

meal89 = Meal.new(name: "Maximo Burger")
meal89.restaurant = Restaurant.find(9)
meal89.category = Category.find_by(name: "Burger")
meal89.picture = "burger-35.jpg"
meal89.save!

meal90 = Meal.new(name: "VeggyLeggy Burger")
meal90.restaurant = Restaurant.find(10)
meal90.category = Category.find_by(name: "Burger")
meal90.picture = "burger-36.jpg"
meal90.save!

meal91 = Meal.new(name: "Poleta Burger")
meal91.restaurant = Restaurant.find(10)
meal91.category = Category.find_by(name: "Burger")
meal91.picture = "burger-37.jpg"
meal91.save!

meal92 = Meal.new(name: "Amareo Burger")
meal92.restaurant = Restaurant.find(10)
meal92.category = Category.find_by(name: "Burger")
meal92.picture = "burger-38.png"
meal92.save!

meal93 = Meal.new(name: "Lisandro Burger")
meal93.restaurant = Restaurant.find(10)
meal93.category = Category.find_by(name: "Burger")
meal93.picture = "burger-39.jpg"
meal93.save!

meal94 = Meal.new(name: "Marca Burger")
meal94.restaurant = Restaurant.find(10)
meal94.category = Category.find_by(name: "Burger")
meal94.picture = "burger-40.jpg"
meal94.save!

meal95 = Meal.new(name: "Destro Burger")
meal95.restaurant = Restaurant.find(10)
meal95.category = Category.find_by(name: "Burger")
meal95.picture = "burger-41.jpg"
meal95.save!

meal96 = Meal.new(name: "Recrella Burger")
meal96.restaurant = Restaurant.find(10)
meal96.category = Category.find_by(name: "Burger")
meal96.picture = "burger-42.jpg"
meal96.save!

meal97 = Meal.new(name: "El Mejor Burger")
meal97.restaurant = Restaurant.find(10)
meal97.category = Category.find_by(name: "Burger")
meal97.picture = "burger-43.jpg"
meal97.save!

puts "created some 95... real meals ..."


# meal5 = Meal.new(name: "Pho Pia Kai")
# meal5.restaurant = Restaurant.find(26)
# meal5.category = Category.find_by(name: "Noodles")
# meal5.picture = "pho-pia-kai-el-petit-bangkok.jpg"
# meal5.save!

# meal6 = Meal.new(name: "Pho Pia Kung")
# meal6.restaurant = Restaurant.find(26)
# meal6.category = Category.find_by(name: "Noodles")
# meal6.picture = "pho-pia-kung-el-petit-bangkok.jpeg"
# meal6.save!


# meal16 = Meal.new(name: "Patatas Bravas")
# meal16.restaurant = Restaurant.find(39)
# meal16.category = Category.find_by(name: "Tapas")
# meal16.picture = "patatas-bravas-39.jpeg"
# meal16.save!

# meal17 = Meal.new(name: "Pulpo Gallego")
# meal17.restaurant = Restaurant.find(39)
# meal17.category = Category.find_by(name: "Tapas")
# meal17.picture = "pulpo-gallego-39.jpg"
# meal17.save!

# meal18 = Meal.new(name: "Croquette de Pollo")
# meal18.restaurant = Restaurant.find(39)
# meal18.category = Category.find_by(name: "Tapas")
# meal18.picture = "croquette-de-pollo-39.jpeg"
# meal18.save!

# meal19 = Meal.new(name: "Tortilla Espanola")
# meal19.restaurant = Restaurant.find(39)
# meal19.category = Category.find_by(name: "Tapas")
# meal19.picture = "tortilla-espanola-39.jpeg"
# meal19.save!

# meal20 = Meal.new(name: "Patatas Bravas")
# meal20.restaurant = Restaurant.find(40)
# meal20.category = Category.find_by(name: "Tapas")
# meal20.picture = "patatas-bravas-40.jpeg"
# meal20.save!

# meal21 = Meal.new(name: "Pulpo Gallego")
# meal21.restaurant = Restaurant.find(40)
# meal21.category = Category.find_by(name: "Tapas")
# meal21.picture = "pulpo-gallego-40.jpg"
# meal21.save!

# meal22 = Meal.new(name: "Croquette de Pollo")
# meal22.restaurant = Restaurant.find(40)
# meal22.category = Category.find_by(name: "Tapas")
# meal22.picture = "croquette-de-pollo-40.jpg"
# meal22.save!

# meal23 = Meal.new(name: "Tortilla Espanola")
# meal23.restaurant = Restaurant.find(40)
# meal23.category = Category.find_by(name: "Tapas")
# meal23.picture = "tortilla-espanola-40.jpg"
# meal23.save!

# meal24 = Meal.new(name: "Patatas Bravas")
# meal24.restaurant = Restaurant.find(43)
# meal24.category = Category.find_by(name: "Tapas")
# meal24.picture = "patatas-bravas-43.jpeg"
# meal24.save!

# meal25 = Meal.new(name: "Pulpo Gallego")
# meal25.restaurant = Restaurant.find(43)
# meal25.category = Category.find_by(name: "Tapas")
# meal25.picture = "pulpo-gallego-43.jpg"
# meal25.save!

# meal26 = Meal.new(name: "Croquette de Pollo")
# meal26.restaurant = Restaurant.find(43)
# meal26.category = Category.find_by(name: "Tapas")
# meal26.picture = "croquette-de-pollo-43.jpg"
# meal26.save!

# meal27 = Meal.new(name: "Tortilla Espanola")
# meal27.restaurant = Restaurant.find(43)
# meal27.category = Category.find_by(name: "Tapas")
# meal27.picture = "tortilla-espanola-43.jpg"
# meal27.save!

# meal28 = Meal.new(name: "Patatas Bravas")
# meal28.restaurant = Restaurant.find(34)
# meal28.category = Category.find_by(name: "Tapas")
# meal28.picture = "patatas-bravas-34.jpg"
# meal28.save!

# meal29 = Meal.new(name: "Pulpo Gallego")
# meal29.restaurant = Restaurant.find(34)
# meal29.category = Category.find_by(name: "Tapas")
# meal29.picture = "pulpo-gallego-34.jpg"
# meal29.save!

# meal30 = Meal.new(name: "Croquette de Pollo")
# meal30.restaurant = Restaurant.find(34)
# meal30.category = Category.find_by(name: "Tapas")
# meal30.picture = "croquette-de-pollo-34.jpg"
# meal30.save!

# meal31 = Meal.new(name: "Tortilla Espanola")
# meal31.restaurant = Restaurant.find(34)
# meal31.category = Category.find_by(name: "Tapas")
# meal31.picture = "tortilla-espanola-34.jpg"
# meal31.save!

puts "-----------------------------------"
puts "-----------------------------------"
puts "Destroying all awards"
Award.destroy_all

reviews_array = [
  "Awesome place, great atmosphere, definitely the best meal I have had in a while.",
  "This was one of the best mouth-watering meals I’ve had grace my taste buds in a long time.",
  "It was much better than I expected. The food was flavorful, savory, and succulent. I’m definitely coming back for more!",
  "After my meal, I was knocked into a food coma. Everything I tried was bursting with flavor. I would eat here every day if I could afford it!",
  "Yummers! Everything from the starters to the entrees to the desserts meshed perfectly with my flavor-profile.",
  "The food was cooked to perfection. They got a new customer for life!",
  "I stumbled on this undiscovered gem right in our neighborhood. Everything I tried was bursting with flavor.",
  "Had dinner with girl friends. Food is perfect, something for everyone. Service was awesome and Jason was very accommodating. Will be back definitely!",
  "The food was absolutely wonderful, from preparation to presentation, very pleasing.",
  "The food was fresh, properly prepared and a great value for the price. We highly recommend it.",
  "The food was amazing, and we enjoyed perfect service.",
]

array_of_all_burger_meals = Meal.where(category_id: 3)
array_of_all_pizza_meals = Meal.where(category_id: 24)
array_of_all_users = User.all

puts "-------------------------"
puts "Assigning burger awards from each user"
User.all.each do |user|
  award = Award.new
  award.meal = array_of_all_burger_meals.sample
  award.review = reviews_array.sample
  award.user = user
  award.save!
end
puts "Assigning pizza awards from each user"
User.all.each do |user|
  award = Award.new
  award.meal = array_of_all_pizza_meals.sample
  award.review = reviews_array.sample
  award.user = user
  award.save!
end

# puts "Creating 800 awards"
# 800.times do
#   award = Award.new
#   award.meal = Meal.all.sample
#   award.user = User.all.sample
#   award.review = Faker::Restaurant.review
#   award.save!
# end
# puts '800 awards with faker reviews distributed'
puts "created 808 awards, 2 per user"
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
