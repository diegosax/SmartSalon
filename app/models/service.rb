class Service < ActiveRecord::Base
  attr_accessible :duration, :name, :price, :professional_id  
  has_many :professional_services
  has_many :professionals, :through => :professional_services
  has_many :events
end