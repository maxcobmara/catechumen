class StudentDisciplineCase < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  
  before_save :close_if_no_case
  
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
  
  named_scope :new,       :conditions => [ "status =?", "New"           ]
  named_scope :opencase,  :conditions => [ "status =?", "Open"          ]
  named_scope :tphep,     :conditions => [ "status =?", "Refer to TPHEP"]
  named_scope :bpl,       :conditions => [ "status =?", "Refer to BPL"  ]
  named_scope :closed,    :conditions => [ "status =?", "Closed"        ]
  
  FILTERS = [
    {:scope => "new",   :label => "New"},
    {:scope => "opencase",  :label => "Open"},
    {:scope => "tphep", :label => "Refer to TPHEP"},
    {:scope => "bpl",   :label => "Refer to BPL"},
    {:scope => "closed",:label => "Closed"}
  ]
  
  def close_if_no_case
    if action_type == "no_case" || action_type == "advise" || action_type == "counseling"
      self.status = "Closed"
    elsif action_type == "Ref TPHEP"
      self.status = "Refer to TPHEP"
    end
    if action_type != "Refer to BPL"
      self.sent_to_board_on = nil
    end
  end
  

    
  # Data Stuff-----------------------------------------------
  INFRACTION = [
         #  Displayed       stored in db
         [ "Merokok", 1  ],
         [ "Ponteng Kelas", 2 ],
         [ "Bergaduh", 3 ],
         [ "Lain Lain", 4 ]
      ]
    
    def status_workflow
    flow = Array.new
      if status == nil
        flow << "New"
      elsif status == "New"
        flow << "Open" 
      elsif status == "Open"
        flow << "Open" << "Refer to TPHEP" << "Closed" 
      elsif status == "Refer to TPHEP"
        flow << "Refer to TPHEP" << "Refer to BPL" << "Closed"
      elsif status == "Refer to BPL"
        flow << "Refer to BPL" << "Closed"
      else
    end
    flow
    end

    
   STATUS = [
         #  Displayed       stored in db
         [ "New","New" ],
         [ "Open","Open" ],
         [ "No Case","No Case" ],
         [ "Closed", "Closed" ],
         [ "Refer to BPL", "Refer to BPL" ]
    ]
    
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
      cofile.blank? ? "Not Assigned" : " #{cofile.name}"  
    end
    
    def room_no
      location.blank? ? "Not Assigned" : " #{location.location_list}"  
    end
end
