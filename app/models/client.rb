class Client < User
  has_many :events
  has_many :client_salons
  has_many :salons, :through => :client_salons
  validates :name, :presence => true

  def favorite_salons
  end

end
