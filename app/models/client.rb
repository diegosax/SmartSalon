class Client < User
  has_many :events
  has_many :client_salons
  has_many :salons, :through => :client_salons
  has_many :favorites
  validates :name, :presence => true  

  def my_salons_and_favorites
  	self.favorites.map(&:salon) | self.salons
  end

end
