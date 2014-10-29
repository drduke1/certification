class AddValidateCodetoUsers < ActiveRecord::Migration
  def change
    add_column :users, :validate_code, :string
  end
end
