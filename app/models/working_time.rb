class WorkingTime < ActiveRecord::Base
  attr_accessible :day, :from, :to
  validates :day, :from, :to, presence: true
  belongs_to :professional

  def day_name
  	Date::DAYNAMES[self.day]	
  end
end
