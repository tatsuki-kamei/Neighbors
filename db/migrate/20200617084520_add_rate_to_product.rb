class AddRateToProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :rate, :float
  end
end
