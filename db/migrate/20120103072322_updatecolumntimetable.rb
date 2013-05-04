class Updatecolumntimetable < ActiveRecord::Migration
  def self.up
    rename_column :timetables, :klass_id,  :classroom_id
  end

  def self.down
    rename_column :timetables, :classroom_id, :klass_id
  end
end
