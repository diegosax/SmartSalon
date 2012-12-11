class Client < User
  has_many :events
  has_many :client_salons
  has_many :salons, :through => :client_salons
  has_many :favorites
  has_many :client_services
  has_many :services, :through => :client_services
  validates :name, :presence => true  
  validates :celphone, :presence => true
  after_create :send_email_notice

  def my_salons_and_favorites
  	self.favorites.map(&:salon) | self.salons
  end

  def send_email_notice  	
  	if self.created_by
  		@salon = Salon.find(self.created_by)  		
  		UserMailer.registration_by_salon_notice(self,@salon).deliver  		
  	else
		UserMailer.registration_notice(self).deliver
  	end
  end

end
