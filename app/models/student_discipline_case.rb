class StudentDisciplineCase < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  
  before_save :close_if_no_case
  before_destroy :check_case_referred_for_counseling
  
  belongs_to :staff, :foreign_key => 'reported_by'
  belongs_to :ketua, :class_name => 'Staff', :foreign_key => 'assigned_to'
  belongs_to :tphep, :class_name => 'Staff', :foreign_key => 'assigned2_to'
  
  belongs_to :location
  belongs_to :student
  belongs_to :cofile, :foreign_key => 'file_id'
  
  has_many :student_counseling_sessions, :foreign_key => 'case_id', :validate => false#, :dependent => :destroy
  accepts_nested_attributes_for :student_counseling_sessions#, :reject_if => lambda { |a| a[:requested_at].blank? }
  
  
  validates_presence_of :reported_by, :student_id, :status, :infraction_id, :assigned_to
  
  #validate :confimed_date
  
  #def validate_end_date_before_start_date
    #if leavenddate && leavestartdate
      #errors.add(:leavenddate, "Your leave must begin before it ends") if leavenddate < leavestartdate || leavestartdate < DateTime.now
    #end
  #end
  
  named_scope :all, :conditions => ["status is not null"]
  named_scope :new2,       :conditions => [ "status =?", "New"           ]      #named_scope :new
  named_scope :opencase,  :conditions => [ "status =?", "Open"          ]
  named_scope :tphep,     :conditions => [ "status =?", "Refer to TPHEP"]
  named_scope :bpl,       :conditions => [ "status =?", "Refer to BPL"  ]
  named_scope :closed,    :conditions => [ "status =?", "Closed"        ]
  
  FILTERS = [
    {:scope => "all", :label => I18n.t('studentdiscipline.all')},
    {:scope => "new2",   :label => I18n.t('studentdiscipline.new2')},                                      #:scope => "new"
    {:scope => "opencase",  :label =>  I18n.t('studentdiscipline.open')},
    {:scope => "tphep", :label =>  I18n.t('studentdiscipline.refer_tphep')},
    {:scope => "bpl",   :label =>  I18n.t('studentdiscipline.refer_bpl')},
    {:scope => "closed",:label => I18n.t('studentdiscipline.closed')}
  ]  
  
  def close_if_no_case
    if action_type == "no_case" || action_type == "advise" #|| action_type == "counseling"
      self.status = "Closed"
    # self.assigned2_to = nil
    #elsif action_type == "counseling"
      #self.assigned2_to = nil
    elsif action_type == "Ref TPHEP"
      self.status = "Refer to TPHEP"
      self.closed_at_college_on = nil
    end
    #if action_type != "Refer to BPL"	#asal
    if action_type != "Ref to BPL"
      self.sent_to_board_on = nil
    else
      self.status = "Refer to BPL"		#baru
    end
    #tumpang - for testing
    if Student.find(student_id).course_id == 4
    	self.assigned_to = Position.find_by_positioncode('1.1.04').staff_id  #self.assigned_to = 69
    else
    end
  end
  
  # Data Stuff-----------------------------------------------
  INFRACTION = [
         #  Displayed       stored in db
         [ I18n.t('studentdiscipline.smooking'), 1  ],
         [ I18n.t('studentdiscipline.skip_class'), 2 ],
         [ I18n.t('studentdiscipline.quarrel'), 3 ],
         [ I18n.t('studentdiscipline.others'), 4 ]
      ]
    
    #note : status - in English all the time
    def status_workflow
    flow = Array.new
      if status == nil
        flow << [ I18n.t('studentdiscipline.new2'),"New"]
      #------------
      elsif status == "New"  
        if reported_by == nil || student_id == nil || status == nil || infraction_id == nil || assigned_to == nil
        	flow << [ I18n.t('studentdiscipline.new2'),"New"]	#special case for 1st time data entry (upon validation-if any of the above field is nil --> stay with 'New' status)
        else
        	flow << [ I18n.t('studentdiscipline.open'),"Open"]<< [ I18n.t('studentdiscipline.refer_tphep'), "Refer to TPHEP"] << [ I18n.t('studentdiscipline.closed'),"Closed"]
        end
      #------------
      #elsif status == "New"	#asal
        #flow << "Open" 		#asal
      #elsif status == "Open"	#asal
      ####elsif status == "New"		#baru  -- jab
        #####flow << "Open" << "Refer to TPHEP" << "Closed" ---jab
      
      elsif status == "Refer to TPHEP"
        #flow << "Refer to TPHEP" << "Refer to BPL" << "Closed"		#asal
        #flow << "Refer to TPHEP" << "Refer to BPL" << "Closed" << "Open"		#baru-24Dec2012
        flow << [ I18n.t('studentdiscipline.refer_bpl'), "Refer to BPL"] << [ I18n.t('studentdiscipline.closed'), "Closed"]		#baru
      elsif status == "Refer to BPL"
        flow << [ I18n.t('studentdiscipline.refer_bpl'), "Refer to BPL"] << [ I18n.t('studentdiscipline.new2'),"New"]
      else
    end
    flow
    end
    
   STATUS = [
         #  Displayed       stored in db
         [ I18n.t('studentdiscipline.new2'),"New" ],
         [ I18n.t('studentdiscipline.open'),"Open" ],
         [ I18n.t('studentdiscipline.no_case'),"No Case" ],
         [ I18n.t('studentdiscipline.closed'), "Closed" ],
         [ I18n.t('studentdiscipline.refer_bpl'), "Refer to BPL" ],   
         [ I18n.t('studentdiscipline.refer_tphep'), "Refer to TPHEP"]
    ] 
   
    def render_status
      (StudentDisciplineCase::STATUS.find_all{|disp, value| value == status }).map {|disp, value| disp}
    end
    
    def render_infraction
      (StudentDisciplineCase::INFRACTION.find_all{|disp, value| value == infraction_id }).map {|disp, value| disp}
    end
    
    def reporter_details 
      suid = Array(reported_by)
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists     

      if reported_by == nil
        "" 
      elsif checker == []
        "Staff No Longer Exists" 
      else
        staff.mykad_with_staff_name
      end
    end
    
    def student_name
      student.blank? ? "Student No Longer Exists" : " #{student.formatted_mykad_and_student_name}" 
    end
    
    def file_name
      cofile.blank? ? I18n.t('not_assigned') : " #{cofile.name}"  
    end
    
    def room_no
      location.blank? ?  I18n.t('not_assigned') : " #{location.location_list}"  
    end
    
    def self.display_msg(err)
      full_msg=[]
      err.each do |k,v|
        full_msg << v
      end
      full_msg
    end
    
    private
    
    def check_case_referred_for_counseling
      counseling_sessions=StudentCounselingSession.find(:all, :conditions=>['case_id=?',id])
      if counseling_sessions && counseling_sessions.count > 0
        errors.add(:base, I18n.t('studentdiscipline.removal_prohibited_for_referred_case'))
        return false
      else
        return true
      end
    end
    
end
