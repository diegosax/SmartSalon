class ProfessionalService < ActiveRecord::Base
  attr_accessible :professional_id, :service_id, :duration, :professional, :service
  belongs_to :service
  belongs_to :professional
  validates :service_id, :uniqueness => {:scope => :professional_id}
  
end
