class CreateVote < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
    	t.integer :user_id, null: false
    	t.integer :question_id, null: false
    	t.integer :answer_id, null: false
        t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :question_id
    add_index :votes, :answer_id
  end
end