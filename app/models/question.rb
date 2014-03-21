class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	belongs_to :user
	default_scope -> { order('created_at ASC') }
	validates :product_id, presence: true
	validates :content, length: { maximum: 1000 }
end
