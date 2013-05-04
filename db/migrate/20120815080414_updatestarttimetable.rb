class Updatestarttimetable < ActiveRecord::Migration
  def self.up
    change_column :timetables,  :start_at,    :datetime
  end

  def self.down
     change_column :timetables,  :start_at,    :datetime
  end
end
