class Client < User
  has_many :events
  validates :name, :presence => true
end
