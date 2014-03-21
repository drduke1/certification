class AddIndexToQuestions < ActiveRecord::Migration
  def change
  	add_index :questions, [:product_id, :created_at]
  end
end
