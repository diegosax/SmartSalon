#encoding: utf-8

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

  def self.text_search(query)
    if query.present?
      where("name like :q", q: "%#{query}%")
    else
      scoped
    end
  end

  def distance_in_kilometers
    new_dsitance = (self.distance * 1.609344).round(2)
    new_dsitance < 1 ? "#{new_dsitance*1000} metros" : "#{new_dsitance} quilômetros"

  end

end
