class CreateProductHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :product_hashtags do |t|
      t.references :product, index: true, foreign_key: true
      t.references :hashtag, index: true, foreign_key: true
    end
  end
end
