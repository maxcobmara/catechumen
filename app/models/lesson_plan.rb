class LessonPlan < ActiveRecord::Base
  
  before_save :set_to_nil_where_false, :assign_topic_intake_id
  
  belongs_to :lessonplan_owner,   :class_name => 'Staff',                 :foreign_key => 'lecturer'
  belongs_to :lessonplan_creator, :class_name => 'Staff',                 :foreign_key => 'prepared_by'
  belongs_to :lessonplan_intake,  :class_name => 'Intake',                :foreign_key => 'intake_id'
  belongs_to :lessonplan_topic,   :class_name => 'Programme',             :foreign_key => 'topic'
  belongs_to :endorser,           :class_name => 'Staff',                 :foreign_key => 'endorsed_by'
  belongs_to :schedule_item,      :class_name => 'WeeklytimetableDetail', :foreign_key => 'schedule'
  
  has_many :lessonplan_methodologies, :dependent => :destroy
  accepts_nested_attributes_for :lessonplan_methodologies, :allow_destroy => true#, :reject_if => lambda { |a| a[:start_at].blank? }
  
  validate :approved_or_rejected, :satisfy_or_notsatisfy
  validates_presence_of :schedule
  
  #trial section------------
  has_many :lesson_plan_trainingnotes
  accepts_nested_attributes_for :lesson_plan_trainingnotes, :reject_if => lambda {|a| a[:trainingnote_id].blank?}
  has_many :trainingnotes, :through => :lesson_plan_trainingnotes
  accepts_nested_attributes_for :trainingnotes, :reject_if => lambda {|a| a[:topic_id].blank?}
  #trial section------------
  
  def set_to_nil_where_false
    if is_submitted == true
      self.submitted_on	= Date.today
    end
    
    if hod_approved == false
      self.hod_approved_on	= nil
    end
    
    if hod_rejected == true && endorsed_by == User.current_user.staff_id
      self.is_submitted = nil
   end
   
   if prepared_by == nil
      self.prepared_by = User.current_user.staff_id
   end
   
   if report_submit == true
      report_submit_on = Date.today
   end   
   
   if report_summary != nil
      self.report_endorsed = true
      self.report_endorsed_on = Date.today
   end  
   
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
  
  def hods  
      hod = User.current_user.staff.position.parent
      approver = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", hod]).map(&:staff_id)
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
