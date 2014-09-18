class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :option
      t.integer :question_id
      t.boolean :correct

      t.timestamps
    end
  end
end
