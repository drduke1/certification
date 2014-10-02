class Section < ActiveRecord::Base
  has_many :product_sections
  has_many :products, through: :product_sections

  accepts_nested_attributes_for :products
end
