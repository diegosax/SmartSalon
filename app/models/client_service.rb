class ClientService < ActiveRecord::Base
	include ActiveModel::Validations  	
	attr_accessible :service_id, :client_id, :duration, :service, :client
	belongs_to :service
	belongs_to :client
	belongs_to :salon
	validates_uniqueness_of :service_id, :scope => [:client_id, :salon_id]
	validates_presence_of :service, :client
	validates :duration, numericality: {greater_than: 0}
	validates_with DivisibleValidator
end
