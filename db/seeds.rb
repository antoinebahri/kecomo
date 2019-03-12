# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

client_id = VGQ5PRPHTBC33UG5AO1XMGNMO1TAWZ32JCUN1HIVF4UW2QGJ
client_secret = ZT5N4QXUKB3TFNRP5TZSAEI1DOLQVE333SNAVR5PFHTISKDD

url = "https://api.foursquare.com/v2/venues/explore?client_id=#{client_id}&client_secret=#{client_secret}&v=20180323&near=barcelona&query=restaurants"

places_serialized = open(url).read
places_list = JSON.parse(places_serialized)


places_list[:response][:groups][0][:items].each do |place|
  url_photo = "https://api.foursquare.com/v2/venues/#{place[:venue][:id]}/photos?client_id=client_id&client_secret=#{client_secret}&v=20180323"

  photo_serialized = open(url).read
  photo_json = JSON.parse(photo_serialized)

  Restaurant.new(name: place[:venue][:name], address: place[:venue][:location][:address], city: place[:venue][:location][:city], category: place[:venue][:categories][0][:name], picture: "#{photo_serialized[:response][:photos][:items][0][:prefix]}/500x500/#{photo_serialized[:response][:photos][:items][0][:suffix]}", longitude: place[:venue][:location][:lng], place[:venue][:location][:lat])

end
