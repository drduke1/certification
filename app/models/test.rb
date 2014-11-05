class Test < ActiveRecord::Base
  has_many :question_tests
  has_many :questions, through: :question_tests
  accepts_nested_attributes_for :questions
  
  attr_accessor :total, :section, :percent
  
  self.inheritance_column = nil
  
  validates :name, presence: true
  validates :type, presence: true
  validates :description, presence: true
  
end
