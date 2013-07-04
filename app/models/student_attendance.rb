class StudentAttendance < ActiveRecord::Base
  belongs_to :weeklytimetable_detail, :foreign_key => 'weeklytimetable_details_id'
  belongs_to :student
  #validates_uniqueness_of :student_id, :scope => :weeklytimetable_details_id, :message => " - Attendance for this student was already created for selected schedule/class"
  
  attr_accessor :lecturer_id
  
  def subject_day_time
    "#{WeeklytimetableDetail.find(weeklytimetable_details_id)}"
  end
  
  #2June2013
  def self.search2(search)
      if search
          if search == '0'
              @student_attendances = StudentAttendance.all
          else
              @student_attendances = StudentAttendance.find(:all, :conditions=>['weeklytimetable_details_id=?',search])
          end
      else
          @student_attendances = StudentAttendance.all
      end
  end
  
end
