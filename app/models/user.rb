class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	has_many :questions
	has_many :scores
	serialize :permission

	validates :name, presence: true, length: { maximum: 50 }
	validates :permission, presence: true
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
						        uniqueness: { case_sensitive: false }
	
  validates :password, :presence => true, :confirmation => true, length: {minimum: 6}, :if => :password
  
	attr_accessor	:taking, :code			        
	
						        
	has_secure_password
	
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	
	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	
	private 
	
		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end
	
end
