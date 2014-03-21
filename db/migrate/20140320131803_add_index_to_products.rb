class AddIndexToProducts < ActiveRecord::Migration
  def change
  	add_index :products, [:id]
  end
end
