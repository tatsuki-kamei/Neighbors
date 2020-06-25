class AddImpressionsCountToQuestion < ActiveRecord::Migration[5.2]
  def change
  	add_column :questions, :impressions_count, :int
  end
end
