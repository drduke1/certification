class Product < ActiveRecord::Base
  has_many :product_sections
  has_many :sections, through: :product_sections
  accepts_nested_attributes_for :sections
  
  validates :name, presence: true
  validates :category, presence: true
end
