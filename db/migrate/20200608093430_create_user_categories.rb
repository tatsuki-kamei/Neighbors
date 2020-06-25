class CreateUserCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_categories do |t|
      t.references :user, foreign_key: true
      t.string :category_id, index: true

      t.timestamps
    end
  end
end
