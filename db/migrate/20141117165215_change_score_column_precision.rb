class ChangeScoreColumnPrecision < ActiveRecord::Migration
  def change
    change_column :scores, :scores, :decimal, :precision => 16, :scale => 2
  end
end
