class Professional < User
  # attr_accessible :title, :body
  has_many :events
  has_many :professional_services
  has_many :services, :through => :professional_services
  belongs_to :salon
end
