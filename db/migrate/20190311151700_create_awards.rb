class CreateAwards < ActiveRecord::Migration[5.2]
  def change
    create_table :awards do |t|
      t.references :user, foreign_key: true
      t.references :meal, foreign_key: true
      t.text :review

      t.timestamps
    end
  end
end
