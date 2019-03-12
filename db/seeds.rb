# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Deleting seeds...'
Award.delete_all
Meal.delete_all
Category.delete_all
Restaurant.delete_all

puts "Creating empty arrays"
user_index_array = []
cat_index_array = []
rest_index_array = []
meal_index_array = []
award_index_array = []

puts 'Creating categories...'
  Category.create(name: 'Burger');
  Category.create(name: 'Pizza');
  Category.create(name: 'Noodles');
puts 'Done'

puts 'Seeding empty array of categories with their indices'
Category.all.each do |cat|
  cat_index_array << cat.id
end

puts 'Creating restaurants...'
  Restaurant.create(name: 'Bacoa', address: 'Rambla 123', city: 'Barcelona', restaurant_category: 'American', description: 'Dope');
  Restaurant.create(name: 'Timesburg', address: 'Rambla 456', city: 'Barcelona', restaurant_category: 'American', description: 'Cool');
  Restaurant.create(name: 'McDonalds', address: 'Rambla 789', city: 'Barcelona', restaurant_category: 'American', description: 'Ass');
puts 'Done'

puts 'Seeding empty array of restaurants with their indices'
Restaurant.all.each do |restaurant|
  rest_index_array << restaurant.id
end

puts 'Creating meals...'
  Meal.create(name: 'Chorizo Burger', description: 'Amazing', restaurant_id: rest_index_array[0], category_id: cat_index_array[0]);
  Meal.create(name: 'Picanha Burger', description: 'Great', restaurant_id: rest_index_array[1], category_id: cat_index_array[0]);
  Meal.create(name: 'Big Mac', description: 'Plastic', restaurant_id: rest_index_array[2], category_id: cat_index_array[0]);
puts 'Done'

puts 'Seeding empty array of meals with their indices'
Meal.all.each do |meal|
  meal_index_array << meal.id
end

puts 'Creating users...'
  User.create(first_name: 'Juan', last_name: 'Goycochea', email: 'jgoyco@gmail.com', password: '123456');
  User.create(first_name: 'Alberto', last_name: 'Goycochea', email: 'agoyco@gmail.com', password: '123456');
  User.create(first_name: 'Luis', last_name: 'Goycochea', email: 'lgoyco@gmail.com', password: '123456');
puts 'Done'

puts 'Seeding empty array of users with their indices'
User.all.each do |user|
  user_index_array << user.id
end

puts 'Creating awards...'
  Award.create(review: 'Boom', meal_id: meal_index_array[0], category_id: cat_index_array[0], user_id: user_index_array[0]);
  Award.create(review: 'Boom', meal_id: meal_index_array[0], category_id: cat_index_array[0], user_id: user_index_array[0]);
  Award.create(review: 'Boom', meal_id: meal_index_array[0], category_id: cat_index_array[0], user_id: user_index_array[0]);
  Award.create(review: 'Boo Yah', meal_id: meal_index_array[1], category_id: cat_index_array[0], user_id: user_index_array[1]);
  Award.create(review: 'Boo Yah', meal_id: meal_index_array[1], category_id: cat_index_array[0], user_id: user_index_array[1]);
  Award.create(review: 'Bullshit', meal_id: meal_index_array[2], category_id: cat_index_array[0], user_id: user_index_array[2]);
puts 'Done'
