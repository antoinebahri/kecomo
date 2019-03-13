class AddIconToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :icon, :string
  end
end
