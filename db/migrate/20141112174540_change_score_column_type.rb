class ChangeScoreColumnType < ActiveRecord::Migration
  def change
    change_column :scores, :scores, :decimal
  end
end
