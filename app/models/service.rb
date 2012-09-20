class Service < ActiveRecord::Base
  attr_accessible :duration, :name, :price, :professional_id  
  validates :name, :presence => true
  validates :duration, :presence => true
  has_many :professional_services
  has_many :professionals, :through => :professional_services
  has_many :events
  belongs_to :salon
end
