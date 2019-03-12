class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :restaurant_category
      t.text :description
      t.integer :opening_hour
      t.integer :closing_hour
      t.string :picture
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
