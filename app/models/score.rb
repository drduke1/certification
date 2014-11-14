class Score < ActiveRecord::Base
  belongs_to :user
  
  #attr_accessor :total, :section, :percent
  
  self.inheritance_column = nil
  
  validates :user_id, presence: true
  validates :test_id, presence: true
  validates :scores, presence: true
  validates :answer_ids, presence: true
  
end
