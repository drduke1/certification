class ProductSection < ActiveRecord::Base
  belongs_to :product
  belongs_to :section
end
