class Weeklytimetable < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  
  #before_save :set_semester
  before_save :set_to_nil_where_false, :intake_must_match_with_programme
  
  belongs_to :schedule_programme, :class_name => 'Programme',       :foreign_key => 'programme_id'
  belongs_to :schedule_semester,  :class_name => 'Programme',       :foreign_key => 'semester'
  belongs_to :schedule_intake,    :class_name => 'Intake',          :foreign_key => 'intake_id' 
  belongs_to :schedule_creator,   :class_name => 'Staff',           :foreign_key => 'prepared_by'
  belongs_to :schedule_approver,  :class_name => 'Staff',           :foreign_key => 'endorsed_by'
  belongs_to :timetable_monthurs, :class_name => 'Timetable',       :foreign_key => 'format1'
  belongs_to :timetable_friday,   :class_name => 'Timetable',       :foreign_key => 'format2'
  belongs_to :academic_semester,  :class_name => 'AcademicSession', :foreign_key => 'semester'
  
  has_many :weeklytimetable_details, :dependent => :destroy
  accepts_nested_attributes_for :weeklytimetable_details, :allow_destroy => true#, :reject_if => lambda { |a| a[:start_at].blank? }
  validates_associated :weeklytimetable_details
  
  validates_presence_of :programme_id, :semester, :intake_id, :format1, :format2
  validate :approved_or_rejected
  
  ##TO RESTRICT 1 Weeklytimetable for 1 programme, of 1 intake, of 1 startdate, of 1 semester
  #validates_uniqueness_of :programe_id, :scope =>[:intake_id, :startdate, :semester] 
  
  #attr_accessor :subject_id  #for testing grouped programme (subject)
  #before logic
  def set_to_nil_where_false
    if is_submitted == true
      self.submitted_on	= Date.today
    end
    
    if hod_approved == false
      self.hod_approved_on	= nil
    end
    
    if hod_rejected == true && endorsed_by == Login.current_login.staff_id
      self.is_submitted = nil
   end
    
  end
  
  def self.search(programmeid, search)
    if programmeid
      if search!=''
	@weeklytimetables = Weeklytimetable.find(:all,:conditions => ['programme_id=? and startdate=?', programmeid, search])
      else 
        @weeklytimetables = Weeklytimetable.find(:all,:conditions => ['programme_id=?', programmeid])
      end
    else
      @weeklytimetables = Weeklytimetable.find(:all)
    end
  end

  def main_details_for_weekly_timetable
    "#{schedule_programme.programme_list}"+" "+I18n.t('student.intake')+" : "+"#{schedule_intake.name}" +" - ("+I18n.t('time.weeks').titleize+" : "+"#{I18n.l(startdate, :format =>'%d-%m-%Y')}"+" - "+"#{I18n.l(enddate, :format => '%d-%m-%Y')}"+")" 
  end
  
  def hods  
      #tpa = Login.current_login.staff.position.parent
      lecturer_unit = Login.current_login.staff.position.unit
      if lecturer_unit == "Pengkhususan" || lecturer_unit == "Diploma Lanjutan" ||  lecturer_unit == "Pos Basik"
        kp = Position.find(:all, :conditions=>['(unit=? or unit=?)and tasks_main ILIKE(?)', "Pengkhususan", "Pos Basik","%Ketua Program%"])
      else
        kp = Position.find(:all, :conditions=>['unit=? and ancestry_depth=?', lecturer_unit,1]).map(&:id)
      end
      hod=kp
      #hod = [tpa]+kp
      approver = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", hod]).map(&:staff_id)
  end
  
  def self.location_list
    @ll=[] 
		@lecture_location = Location.find(:first, :conditions=>['code=?', 'C']).descendants 
		@lecture_location.each do |kk| 
			if (kk.id == 89)||(kk.id == 90)||(kk.id == 906)||(kk.id == 907) ||(kk.id == 910)||(kk.id == 911)||(kk.id == 912)||(kk.id == 913) 
			   #do nothing
			else 
				@ll<< kk 
			end 
		end 
		return @ll
  end
  
  def approved_or_rejected
    if hod_approved.blank? == false && hod_rejected.blank? == false
        errors.add_to_base("Please choose either to approve or reject this weekly timetable")
    end
  end
  
  def self.validintake_timetable
    #timetable INTAKE must match with PROGRAMME, to exclude prev data entry (wrongly match data [intake_id<->programme_id])
    #valid_intakes=[]
    wt_valid_intakes=[]
    weeklytimetables = Weeklytimetable.all
    weeklytimetables.each do |y|
        intakes_of_prog = Intake.find(:all, :conditions => ['programme_id=?', y.programme_id]).map(&:id)
        #valid_intakes << y.intake_id if intakes_of_prog.include?(y.intake_id)
	wt_valid_intakes << y.id if intakes_of_prog.include?(y.intake_id) #collect WT ids yg guna intake yg betul bkn collect
    end
    wt_valid_intakes.uniq
  end
  
  def self.valid_wt_ids
     #find(:all, :conditions=>['intake_id IN(?)', self.validintake_timetable]).map(&:id)
     find(:all, :conditions=>['id IN(?)', self.validintake_timetable]).map(&:id)
  end
  
  def self.other_lects
    common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan", "Komuniti"]
    common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
    is_admin=true if current_roles.include?("Administration")
    is_programme_mgr=true if current_roles.include?("Programme Manager")
    is_common_lecturer=true if common_subject_lecturers_ids.include?(Login.current_login.staff_id)
    if !is_admin && !is_programme_mgr && !is_common_lecturer && !Intake.all.map(&:staff_id).include?(Login.current_login.staff_id) && !Weeklytimetable.all.map(&:prepared_by).include?(Login.current_login.staff_id)
      other_lecturers=true
    else
      other_lecturers=false
    end
    other_lecturers
  end
  
  private 
    def intake_must_match_with_programme
      valid_intakes = Intake.find(:all, :conditions => ['programme_id=?', programme_id]).map(&:id)
      if valid_intakes.include?(intake_id)
        return true
      else
        errors.add(:base, I18n.t('weeklytimetable.intake_programme_must_match'))
        return false
      end
    end
  
end
