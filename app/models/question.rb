class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	has_many :question_tests
	has_many :tests, through: :question_tests
	belongs_to :user
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:option].blank? }, :allow_destroy => true
  
  attr_accessor :ip_video_telephony_product_id, :enterprise_gateways_product_id, :ip_video_surveillance_product_id, :ip_voice_product_id, :consumer_atas_product_id, :ip_pbx_product_id 
  
	#default_scope -> { order('created_at ASC') }
	
  @category_check = ['ip_voice', 'ip_pbx', 'ip_video_surveillance', 'ip_video_telephony', 'consumer_atas', 'enterprise_gateways']  
    
  validates :product_id, presence: true
  validates :content, length: { maximum: 1000 }
  validates_inclusion_of :category, in: @category_check
      
end
