class AddUserIdForeignKeyToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_reference :restaurants, :user, foreign_key: true
  end
end
