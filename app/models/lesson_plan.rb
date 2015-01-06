class LessonPlan < ActiveRecord::Base
  
  before_save :set_to_nil_where_false,:assign_topic_intake_id, :copy_attached_doc_trainingnotes
  
  belongs_to :lessonplan_owner,   :class_name => 'Staff',                 :foreign_key => 'lecturer'
  belongs_to :lessonplan_creator, :class_name => 'Staff',                 :foreign_key => 'prepared_by'
  belongs_to :lessonplan_intake,  :class_name => 'Intake',                :foreign_key => 'intake_id'
  belongs_to :endorser,                :class_name => 'Staff',                 :foreign_key => 'endorsed_by'
  belongs_to :schedule_item,       :class_name => 'WeeklytimetableDetail', :foreign_key => 'schedule'
  
  has_many :lessonplan_methodologies, :dependent => :destroy
  accepts_nested_attributes_for :lessonplan_methodologies, :allow_destroy => true#, :reject_if => lambda { |a| a[:start_at].blank? }
  
  validate :approved_or_rejected, :satisfy_or_notsatisfy
  validates_presence_of :schedule #require re-selection if schedule no longer exist
  
  has_many :lesson_plan_trainingnotes
  accepts_nested_attributes_for :lesson_plan_trainingnotes, :allow_destroy => true, :reject_if => lambda {|a| a[:trainingnote_id].blank?}
  has_many :trainingnotes, :through => :lesson_plan_trainingnotes
  accepts_nested_attributes_for :trainingnotes, :reject_if => lambda {|a| a[:topic_id].blank?}
  
  attr_accessor :title
  
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
   
   if prepared_by == nil
      self.prepared_by = Login.current_login.staff_id
   end
   
   if report_submit == true
      report_submit_on = Date.today
   end   
   
   if report_summary != nil
      self.report_endorsed = true
      self.report_endorsed_on = Date.today
   end  
   
    #--start--3Nov2013-schedule no longer compulsory
    if schedule != nil
      self.lecture_date = WeeklytimetableDetail.find(schedule).get_date_for_lesson_plan
      self.start_time = WeeklytimetableDetail.find(schedule).get_start_time
      self.end_time = WeeklytimetableDetail.find(schedule).get_end_time
    end
    #--end--3Nov2013-schedule no longer compulsory
    
     #if schedule != nil
       #self.topic = WeeklytimetableDetail.find(schedule).topic
    #end   


   end

   def assign_topic_intake_id
     if schedule != nil
         self.topic = WeeklytimetableDetail.find(schedule).topic
         self.intake_id = Weeklytimetable.find(WeeklytimetableDetail.find(schedule).weeklytimetable_id).intake_id
     end
   end
  #---------------------------
   def copy_attached_doc_trainingnotes
     if data != nil 
         notes_for_lessonplan = Trainingnote.new     
         notes_for_lessonplan.document_file_name = data_file_name
         notes_for_lessonplan.document_content_type = data_content_type
         notes_for_lessonplan.document_file_size = data_file_size
         notes_for_lessonplan.timetable_id = schedule
         notes_for_lessonplan.staff_id = Login.current_login.staff_id
         notes_for_lessonplan.title = title

         #check if topicdetails for topic of selected schedule really exist 
         #topiccode = WeeklytimetableDetail.find(schedule).topic
         @topicdetail = Topicdetail.find_by_topic_code(topic)#code)
         if @topicdetail != nil 
             notes_for_lessonplan.topicdetail_id = @topicdetail.id #new record
             @topicdetail_id = @topicdetail.id                    #update record
         end 

         #check training note existance for current lesson plan(schedule) (IN TRAININGNOTES TABLE)
         @trainingnote_lessonplan = Trainingnote.find_by_timetable_id(schedule)

         #if (new/changed) uploaded file & timetable_id(schedule) not exist[training note NOT EXIST for lesson plan], 
         #==>INSERT NEW note (into trainingnotes table)
         #if training note ALREADY EXIST for lesson plan, 
         #==>UPDATE EXISTING note (in trainingnotes table)

         if Trainingnote.find_by_document_file_name(data_file_name)==nil && Trainingnote.find_by_timetable_id(schedule)==nil
           notes_for_lessonplan.save   
         else  
           if @trainingnote_lessonplan
             @trainingnote_lessonplan.update_attributes(:document_file_name=>data_file_name, :document_content_type=>data_content_type,:document_file_size=>data_file_size, :timetable_id=>schedule, :staff_id=>Login.current_login.staff_id, :title=>title,:topicdetail_id=>@topicdetail_id)
           end
         end
     end 
   end
   
  def hods  
      #hod = Login.current_login.staff.position.parent
      #approver = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", hod]).map(&:staff_id)
      role_kp = Role.find_by_name('Programme Manager')  #must have role as Programme Manager
      staff_with_kprole = Login.find(:all, :joins=>:roles, :conditions=>['role_id=?',role_kp]).map(&:staff_id).compact.uniq
      #programme_name = Programme.roots.map(&:name)    #must be among Academic Staff 
      #approver = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?) AND staff_id IN(?)', programme_name, staff_with_kprole])
      programme_name = Login.current_login.staff.position.unit
      approver = Staff.find(:all, :joins=>:position, :conditions=>['unit=? AND staff_id IN(?)', programme_name, staff_with_kprole])
      approver  
  end
  
  
  #---------------------AttachFile------------------------------------------------------------------------
   has_attached_file :data,
                      :url => "/assets/lesson_plans/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/assets/lesson_plans/:id/:style/:basename.:extension"
   #validates_attachment_content_type :data, 
                          #:content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                          #:storage => :file_system,
                          #:message => "Invalid File Format" 
   validates_attachment_size :data, :less_than => 5.megabytes
   
   def approved_or_rejected
     if hod_approved.blank? == false && hod_rejected.blank? == false
         errors.add_to_base("Please choose either to approve or reject this weekly timetable")
     end
   end
   
    def satisfy_or_notsatisfy
      if condition_isgood.blank? == false && condition_isnotgood.blank? == false
          errors.add_to_base("Please choose either class condition is satisfactory or not satisfactory")
      end
    end
   
end
