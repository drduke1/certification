class ProductSections < ActiveRecord::Migration
  def change
    create_table "product_sections", force: true do |t|
          t.integer "product_id", null: false
          t.integer "section_id", null: false
    end
  end
end
