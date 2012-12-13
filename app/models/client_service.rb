class ClientService < ActiveRecord::Base
	attr_accessible :service_id, :client_id, :duration, :service, :client
	belongs_to :service
	belongs_to :client
	validates_uniqueness_of :service_id, :scope => :client_id
	validates_presence_of :service, :client
	validates :duration, numericality: {greater_than: 0}
end