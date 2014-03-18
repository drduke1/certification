class Answer < ActiveRecord::Base
	belongs_to :question
	validates :content, length: { maximum: 250 }
end
