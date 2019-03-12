class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.references :restaurant, foreign_key: true
      t.references :category, foreign_key: true
      t.string :name
      t.text :description
      t.string :picture

      t.timestamps
    end
  end
end
