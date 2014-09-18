class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
