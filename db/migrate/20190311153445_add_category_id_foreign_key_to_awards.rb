class AddCategoryIdForeignKeyToAwards < ActiveRecord::Migration[5.2]
  def change
    add_reference :awards, :category, foreign_key: true
  end
end
