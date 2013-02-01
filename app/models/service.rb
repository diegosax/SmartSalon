#encoding: utf-8

class Service < ActiveRecord::Base
  attr_accessible :duration, :name, :price
  has_many :professional_services, :dependent => :destroy
  has_many :professionals, :through => :professional_services
  has_many :events
  has_many :client_services
  has_many :clients, :through => :client_services
  belongs_to :salon
  validates :name, :duration, presence: true
  validates :price, numericality: {greater_than: 0}, :allow_blank => true
  validates :duration, numericality: {greater_than: 0}

  def preferred_duration(client)
  	client_service = self.client_services.where(:client_id => client).first
  	if client_service
  		client_service.duration
  	else
  		self.duration
  	end
  end
end
