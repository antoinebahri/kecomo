class AddPhotoToAwards < ActiveRecord::Migration[5.2]
  def change
    add_column :awards, :photo, :string
  end
end
