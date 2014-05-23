class Answer < ActiveRecord::Base
	belongs_to :question	
	#validates :question_id, presence: true
	validates :option, length: { maximum: 250 }
end
