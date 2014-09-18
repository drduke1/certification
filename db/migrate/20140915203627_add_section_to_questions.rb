class AddSectionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :section, :string
  end
end
