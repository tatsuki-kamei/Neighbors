class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.text :name
      t.string :image_id

      t.timestamps
    end
  end
end
