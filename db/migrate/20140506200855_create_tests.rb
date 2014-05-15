class CreateTests < ActiveRecord::Migration
  def change
    drop_table :tests
    
    create_table :tests do |t|
      t.string :name
      t.string :type
      t.string :category
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
