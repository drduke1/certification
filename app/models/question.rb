class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	belongs_to :user
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
    
	default_scope -> { order('created_at ASC') }
	
  @category_check = ['ip_voice', 'ip_pbx', 'ip_video_surveillance', 'ip_video_telephony', 'consumer_atas', 'enterprise_gateways']  
    
  validates :product_id, presence: true
  validates :content, length: { maximum: 1000 }
  validates_inclusion_of :category, in: @category_check
      
   # private
   # def self.category_check
   #     @@category_check = ['ip_voice', 'ip_pbx', 'ip_video_surveillance', 'ip_video_telephony', 'consumer_atas', 'enterprise_gateways']
   # end
end
