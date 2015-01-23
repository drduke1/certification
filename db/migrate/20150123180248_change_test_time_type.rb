class ChangeTestTimeType < ActiveRecord::Migration
  def change
      change_column :tests, :time, :time
    end
end
