class AddScoreToComents < ActiveRecord::Migration[5.2]
  def change
  	add_column :comments, :score, :decimal, precision: 5, scale: 3, :default => 0
  end
end
