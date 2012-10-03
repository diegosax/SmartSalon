#encoding: utf-8

class Salon < ActiveRecord::Base
  attr_accessible :address, :city, :complement, :email, :fone, :logo, :name, :state, :username, :zipcode, :neighborhood, :remote_logo_url
  has_many :services, :dependent => :destroy
  has_many :professionals, :dependent => :destroy
  has_many :events, :through => :professionals
  has_many :client_salons
  has_many :clients, :through => :client_salons
  has_many :favorites
  has_many :subscriptions
  mount_uploader :logo, LogoUploader
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  after_save :create_subscription

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
    if Salon.method_defined? :distance
      new_dsitance = (self.distance * 1.609344).round(2)
      new_dsitance < 1 ? "#{new_dsitance*1000} metros" : "#{new_dsitance} quilômetros"
    else
      nil
    end
  end

  def create_subscription
    subscription = self.subscriptions.build
    subscription.initial_date = DateTime.now
    subscription.trial_period = 2;
    subscription.end_date = subscription.initial_date + 1.year + subscription.trial_period.month
    subscription.price = 80
    subscription.save
  end

end
