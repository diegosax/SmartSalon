#encoding: utf-8
class Event < ActiveRecord::Base
	attr_accessible :changeable, :client_id, :description, :duration, :professional_id, :service_id, :salon_id, :start_at, :status, :title, :end_at, :confirm_conflicts, :reschedule	
	scope :active, :conditions => {:status => "Agendado"}
	scope :canceled, :conditions => {:status => "Cancelado"}
	scope :past, :conditions => ["start_at < ?",Time.zone.now]
	scope :from_today_on, :conditions => ["start_at >= ?",Time.zone.now.beginning_of_day]
	scope :today, :conditions => ["start_at >= ? AND start_at <= ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day]
	scope :mine, lambda { |professional_id| where("professional_id = ?", professional_id) }
	belongs_to :client
	belongs_to :professional
	belongs_to :service
	belongs_to :salon
	validates :title, :presence => true
	validates :start_at, :presence => true
	validates :end_at, :presence => true
	validates_with IsBusyValidator
	validates :end_at, :range => true
	after_save :add_client_to_salon	

	def client_name
		self.client.name if self.client
	end

	def client_name=(nome)
		self.client = Client.find_by_nome(nome)
	end

	def professional_name
		self.professional.name if self.professional
	end

	def professional_name=(name)
		self.professional = Professional.find_by_name(name)
	end	

	def find_conflicts

		Event.where(
	      "
	        (start_at > ? and start_at < ? OR
	        end_at > ? and end_at < ? OR
	        start_at <= ? and end_at >= ?) AND
			professional_id = ? AND
			salon_id = ?
	      ",
	      self.start_at,self.end_at,
	      self.start_at,self.end_at,
	      self.start_at,self.end_at,
	      self.professional.id, self.salon.id
	    ).all
	end



	private
	def add_client_to_salon		
		begin
			self.client.salons << self.salon
		rescue
			puts "Salon/Client already exists"
		end
	end

end