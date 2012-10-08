class WorkingTime < ActiveRecord::Base
  attr_accessible :day, :'from', :to
  validates :day, :'from', :to, presence: true
  belongs_to :professional
  validates_with ConflictValidator

  def day_name
  	Date::DAYNAMES[self.day]	
  end  

  def find_conflicts
  	self.professional.working_times.where(
      "
        'from' > ? and 'from' < ? OR
        'to' > ? and 'to' < ? OR
        'from' <= ? and 'to' >= ?
      ",
      self.from,self.to,
      self.from,self.to,
      self.from,self.to      
    ).all
  end
end
