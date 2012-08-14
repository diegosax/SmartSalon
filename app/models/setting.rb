class Setting < ActiveRecord::Base
  attr_accessible :client_can_schedule, :closing_time, :opening_time, :searchable, :work_on_saturdays, :work_on_sundays
end
