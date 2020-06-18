class AddImpressionsCountToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :impressions_count, :int
  end
end
