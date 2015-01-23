class ChangeTestColumnType < ActiveRecord::Migration
  def change
    add_column :tests, :minute, :string
    add_column :tests, :hour, :string
    change_column :tests, :time, :string
  end
end
