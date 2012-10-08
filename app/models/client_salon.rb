class ClientSalon < ActiveRecord::Base
	attr_accessible :salon_id, :client_id
	belongs_to :salon
	belongs_to :client
	validates_uniqueness_of :salon_id, :scope => :client_id
end
