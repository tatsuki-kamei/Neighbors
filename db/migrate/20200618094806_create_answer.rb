class CreateAnswer < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
    	t.integer :question_id, null: false
    	t.string :text
    	t.timestamps
    end
    add_index :answers, :question_id
  end
end
