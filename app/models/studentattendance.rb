class Studentattendance < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :students
  
  
  def this_timetable_students
    
  end
end
