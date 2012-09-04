class Favorite < ActiveRecord::Base
  attr_accessible :client_id, :salon_id, :salon, :client
  belongs_to :client
  belongs_to :salon
  validates_uniqueness_of :salon_id, :scope => :client_id
end
