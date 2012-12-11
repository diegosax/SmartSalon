class Service < ActiveRecord::Base
  attr_accessible :duration, :name, :price
  has_many :professional_services, :dependent => :destroy
  has_many :professionals, :through => :professional_services
  has_many :events
  belongs_to :salon
  validates :name, :duration, presence: true
  validates :price, numericality: {greater_than: 0}, :allow_blank => true
end
