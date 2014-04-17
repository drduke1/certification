class AddPermissionToUser < ActiveRecord::Migration
  def change
    add_column :users, :permission, :string
  end
end
