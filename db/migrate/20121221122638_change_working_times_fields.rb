class ChangeWorkingTimesFields < ActiveRecord::Migration
  def up
  	change_table :working_times do |t|  	
  		t.rename :from, :from_time
  		t.rename :to, :to_time
	end
  end

  def down
  	change_table :working_times do |t|  	
  		t.rename :from_time, :from
  		t.rename :to_time, :to
	end
  end
end
