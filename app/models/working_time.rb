class WorkingTime < ActiveRecord::Base
  attr_accessible :day, :from_time, :to_time, :professional
  validates :day, :from_time, :to_time, presence: true
  belongs_to :professional
  validates_with ConflictValidator

  def day_name
  	Date::DAYNAMES[self.day]	
  end  

  def find_conflicts
  	self.professional.working_times.where(
      "
        day = ? AND
        (
          (from_time <= ? AND to_time > ?) OR
          (from_time <= ? AND to_time > ?)
        )
      ",
      self.day,
      self.from_time,self.from_time,
      self.to_time,self.to_time
    ).all
  end
end
