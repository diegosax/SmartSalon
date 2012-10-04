class CreateWorkingTimes < ActiveRecord::Migration
  def change
    create_table :working_times do |t|
      t.integer :day
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
