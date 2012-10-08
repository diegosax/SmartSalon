class Professional < User
  # attr_accessible :title, :body
  has_many :events
  has_many :working_times, :dependent => :destroy
  has_many :professional_services, :dependent => :destroy
  has_many :services, :through => :professional_services
  belongs_to :salon
  after_create :create_working_times

  def create_working_times
  	for i in 1..5
  		self.working_times.create(
  			:day => i,
  			:from => Time.zone.parse("08:00"),
  			:to => Time.zone.parse("12:00")  			
  		)
  		self.working_times.create(
  			:day => i,
  			:from => Time.zone.parse("13:00"),
  			:to => Time.zone.parse("17:00")  			
  		)
  	end
  end
end
