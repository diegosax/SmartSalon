class Phone < ActiveRecord::Base
  attr_accessible :number, :salon_id, :type, :user_id
  belongs_to :salon
  belongs_to :user
end
