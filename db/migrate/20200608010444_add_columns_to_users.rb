class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :introduction, :text
  	add_column :users, :image_id, :string
  	add_column :users, :nickname, :string
  end
end
