class Salon < ActiveRecord::Base
  attr_accessible :address, :city, :complement, :email, :fone, :logo, :name, :state, :username, :zipcode, :neighborhood, :remote_logo_url
  has_many :services, :dependent => :destroy
  has_many :professionals, :dependent => :destroy
  has_many :events, :through => :professionals
  mount_uploader :logo, LogoUploader
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  def full_address
  	self.address + ", " + self.city + " - " + self.state + " - " + (self.zipcode ? self.zipcode : "")
  end
end
