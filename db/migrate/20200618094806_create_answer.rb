class CreateAnswer < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
    	t.references :question, foreign_key: true
    	t.string :text
    	t.timestamps
    end
  end
end
