class AddColumnsToTests < ActiveRecord::Migration
  def change
    add_column :tests, :total, :string
    add_column :tests, :section, :string
    add_column :tests, :percent, :string
  end
end
