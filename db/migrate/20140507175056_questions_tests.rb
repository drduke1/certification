class QuestionsTests < ActiveRecord::Migration
  def change
    drop_table "test_questions"
    create_table "questions_tests", id: false, force: true do |t|
      t.integer "test_id",     null: false
      t.integer "question_id", null: false
    end
  end
end
