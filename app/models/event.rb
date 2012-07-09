class Event < ActiveRecord::Base
	attr_accessible :changeable, :client_id, :description, :duration, :professional_id, :start_at, :status, :title
	belongs_to :client
	belongs_to :professional
	validates :title, :presence => true
	#validates :start_at, :isbusy => true
	#validates :end_at, :range => true

	def client_name
		self.client.nome if self.client
	end

	def client_name=(nome)
		self.client = Client.find_by_nome(nome)
	end

	def professional_name
		self.professional.nome if self.professional
	end

	def professional_name=(name)
		self.professional = Professional.find_by_name(name)
	end

end
