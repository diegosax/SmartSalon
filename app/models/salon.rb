class Salon < ActiveRecord::Base
  attr_accessible :address, :city, :complement, :email, :fone, :logo, :name, :state, :username, :zipcode, :neighborhood
  has_many :services, :dependent => :destroy
  has_many :professionals, :dependent => :destroy
  has_many :events, :through => :professionals
end
