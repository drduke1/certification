class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :test_id
      t.string :question_tests
      t.string :scores
      t.boolean :passed

      t.timestamps
    end
  end
end
