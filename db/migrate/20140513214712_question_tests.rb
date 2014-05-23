class QuestionTests < ActiveRecord::Migration
  def change
        create_table "question_tests", force: true do |t|
          t.integer "test_id",     null: false
          t.integer "question_id", null: false
    end
  end
end
