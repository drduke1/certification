class ChangeScoreColumnName < ActiveRecord::Migration
  def change
    rename_column :scores, :question_tests, :answer_ids
  end
end
