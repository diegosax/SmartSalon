class ProfessionalService < ActiveRecord::Base
  attr_accessible :professional_id, :service_id, :duration
  belongs_to :service
  belongs_to :professional
end
