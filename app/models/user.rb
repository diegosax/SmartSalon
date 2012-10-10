class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email,:landphone,:celphone, :password, :password_confirmation, :remember_me,
                :address, :complement, :region, :state
  #validates :celphone, :presence => true

  attr_accessor :role #admin professional client

  def role?(role) 
    self.role == role
  end

  def is_client?
  	self.is_a?(Client)
  end

  def is_professional?
  	self.is_a?(Professional)
  end

end
