#encoding: utf-8

class Salon < ActiveRecord::Base
  attr_accessible :address,:number, :city, :complement, :email, :landphone,:celphone, 
                  :logo, :name, :state, :username, :zipcode, :neighborhood, :manager_attributes,
                  :logo_cache, :remove_logo
  mount_uploader :logo, LogoUploader
  has_many :services, :dependent => :destroy
  has_many :professionals, :dependent => :destroy
  has_many :events, :through => :professionals
  has_many :client_salons
  has_many :client_services
  has_many :clients, :through => :client_salons
  has_many :favorites
  has_many :subscriptions
  has_many :phones
  has_one :manager, :class_name => "Professional"
  validates :name, :username, :presence => true
  validates :username, :uniqueness => true
  accepts_nested_attributes_for :manager
  
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  #after_create :create_subscription

  def full_address
  	self.address + ", " + self.city + " - " + self.state + " - " + (self.zipcode ? self.zipcode : "")
  end

  def is_incomplete?
    incomplete_address? || no_services?
  end

  def incomplete_address?
    !(self.zipcode && self.address && self.city && self.landphone)
  end

  def no_services?
    self.services.length == 0
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
    if subscription.save      
      12.times do |i|
        subscription.payments.create(
          :description => "Mensalidade",
          :status => "A Pagar",
          :price => subscription.price,
          :due_date => Time.zone.today + subscription.trial_period.months + (i-1).month        
        )
      end    
    end
  end

  def to_moip_payer_format
    payer = {
      :nome => self.name,
      :email => self.email,
      :tel_cel => formatted_phone(self.celphone),
      :tel_fixo => formatted_phone(self.landphone),
      :logradouro => self.address,
      :numero => self.number,
      :complemento => self.complement,
      :bairro => self.neighborhood,
      :cidade => self.city,
      :estado => self.state.upcase,
      :pais => "BRA",
      :cep => formatted_zipcode(self.zipcode)
    }
    payer
  end

  private
  def formatted_phone(phone)
    return phone.nil? ? "" : phone.sub(/(\d{2})(\d{4})(\d{4})/, "(\\1)\\2-\\3")
  end

  def formatted_zipcode(zipcode)
    return zipcode.sub(/(\d{5})(\d{3})/, "\\1-\\2")
  end


end
