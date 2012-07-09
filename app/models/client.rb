class Client < User
  # attr_accessible :title, :body
  has_many :events
end
