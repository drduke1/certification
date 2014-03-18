class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.string :type
      t.string :category
      t.integer :product_id
      t.boolean :active

      t.timestamps
    end
  end
end
