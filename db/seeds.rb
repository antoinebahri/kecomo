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

puts "Destroying all restaurants"
Restaurant.destroy_all

url = "https://api.foursquare.com/v2/venues/explore?client_id=#{ENV["FOURSQUARE_CLIENT_ID"]}&client_secret=#{ENV["FOURSQUARE_SECRET_ID"]}&v=20180323&near=barcelona&query=restaurants&limit=50"

places_serialized = HTTParty.get(url).body
places_list = JSON.parse(places_serialized)

puts "Creating restaurants"
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
end
