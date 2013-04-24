class Professional < User
  # attr_accessible :title, :body
  has_many :events
  has_many :working_times, :dependent => :destroy
  has_many :professional_services, :dependent => :destroy
  has_many :services, :through => :professional_services
  scope :has_services
  validates :name,:email,:celphone, :presence => true
  belongs_to :salon
  after_create :init

  def init

    #set_professional_role
    #self.role= "professional"

    #create_working_times
  	for i in 1..5
  		self.working_times.create(
  			:day => i,
  			:from_time => Time.zone.parse("2000-01-01 08:00"),
  			:to_time => Time.zone.parse("2000-01-01 18:00")
  		)  		
  	end
  end
end

