class AddFavoriteToNotification < ActiveRecord::Migration[5.2]
  def change
  	add_column :notifications, :favorite_id, :int
  	add_index :notifications, :favorite_id
  end
end
