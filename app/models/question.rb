class Question < ActiveRecord::Base
	has_many :answers
	belongs_to :user
	validates :content, length: { maximum: 1000 }
end
