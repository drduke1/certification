class AddRegionMinimumToTests < ActiveRecord::Migration
  def change
     add_column :tests, :region, :string
     add_column :tests, :minimum, :string
     add_column :tests, :time, :decimal
   end
end
