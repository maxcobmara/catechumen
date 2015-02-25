class StudentAttendance < ActiveRecord::Base
  belongs_to :weeklytimetable_detail, :foreign_key => 'weeklytimetable_details_id'
  belongs_to :student
  validates_uniqueness_of :student_id, :scope => :weeklytimetable_details_id, :message => " - Attendance for this student was already created for selected schedule/class"
  
  attr_accessor :lecturer_id
  
  def subject_day_time
    "#{WeeklytimetableDetail.find(weeklytimetable_details_id)}"
  end
  
  #2June2013
  def self.search2(search)
      exist_wtd_ids = WeeklytimetableDetail.all.map(&:id)
      if search
          if search == '0'
              #@student_attendances = StudentAttendance.find(:all, :conditions=> ['weeklytimetable_details_id IN(?)', exist_wtd_ids])
	      @student_attendances = StudentAttendance.find(:all, :conditions=> ['weeklytimetable_details_id IN(?) and weeklytimetable_details_id IN(?)', exist_wtd_ids, Login.current_login.classes_taughtby])
          else
              @student_attendances = StudentAttendance.find(:all, :conditions=>['weeklytimetable_details_id=?',search])
          end
      else
          @student_attendances = StudentAttendance.find(:all, :conditions=> ['weeklytimetable_details_id IN(?)', exist_wtd_ids])
      end
  end
  
  #11July2013
  def self.search(search,programme)
      exist_wtd_ids = WeeklytimetableDetail.all.map(&:id)
      if search
        if search == '0'
          @student_attendances = StudentAttendance.find(:all, :conditions=> ['weeklytimetable_details_id IN(?) and weeklytimetable_details_id IN(?)', exist_wtd_ids, Login.current_login.classes_taughtby])
        else
          unless programme.nil?
            @student_attendances = StudentAttendance.find(:all, :joins=>:student, :conditions => ['course_id=? and intake=? and weeklytimetable_details_id IN(?)',programme, search, exist_wtd_ids])
          else #if common subject lecturer, no programme specified
            @student_attendances = StudentAttendance.find(:all, :joins=>:student, :conditions => ['intake=? and weeklytimetable_details_id IN(?)', search, exist_wtd_ids])
          end
        end
      else
        unless programme.nil?
          @student_attendances = StudentAttendance.find(:all, :joins=>:student, :conditions => ['course_id=? and weeklytimetable_details_id IN(?)',programme, exist_wtd_ids])
        else  #if admin
          @student_attendances = StudentAttendance.find(:all, :conditions=> ['weeklytimetable_details_id IN(?)',exist_wtd_ids])
        end
      end
  end
  
  REASON = [
          #  Displayed       stored in db
          [ I18n.t('student_attendance.medical_leave'),"1" ],
          [ I18n.t('student_attendance.emergency'),"2" ],
          [ I18n.t('student_attendance.normal'), "3" ]
   ]
   
   ACTION = [
          #   Displayed     stored in db
         [I18n.t('student_attendance.counseling'),"1"],
         [I18n.t('student_attendance.replace_leave'),"2"],
         [I18n.t('student_attendance.show_cause'),"3"],
         [I18n.t('student_attendance.warning'),"4"],
         [I18n.t('student_attendance.disciplinary'),"5"],
         [I18n.t('student_attendance.attend_replacement_class'),"6"]
     ]
  
end
