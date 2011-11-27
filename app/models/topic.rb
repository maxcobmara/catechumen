class Topic < ActiveRecord::Base
  
  before_save :save_my_vars
  
  has_many :timetables

  belongs_to :subject#, :class_name => 'Subject', :foreign_key => 'subject_id'
  belongs_to :creator, :class_name => 'Staff', :foreign_key => 'creator_id'
  belongs_to :approver, :class_name => 'Staff', :foreign_key => 'approvedby_id'

  validates_presence_of :topic_code, :sequenceno, :name
  validates_uniqueness_of :sequenceno, :scope => :subject_id, :message => 'This sequence is already taken'

    #Link to Model Timetableentry
    #has_many :topic, :class_name => 'Time_table_entry', :foreign_key => 'topic_id'

    def self.find_main
      Topic.find(:all, :condition => ['topic_id IS NULL'])
    end

    def save_my_vars
      self.duration = make_minutes
    end

    def make_minutes
      (durahours * 60) + duramins
    end

    #def self.find_main
       #Subject.find(:all, :condition => ['subject_id IS NULL'])
     #end

     #def self.find_main
       #Staff.find(:all, :condition => ['creator_id IS NULL'])
     #end

     def topics_grouped_by_subject
       ds = Topic.find(:all, :order => "subject_id")
       @ds.in_groups_by(&:subject_id)
       # or the alternative syntax
       ds.in_groups_by { |r| r.subject_id }
     end

     def booba
         #<changed from subject.id to subject_id to solve error RuntimeError in TopicsController#index 
         #Called id for nil, which would mistakenly be 4 -- if you really wanted the id of nil, use object_id
         suid = subject_id 
         Subject.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
     end
     
     
    

     def staff_position
       sid = staff.id
       Position.find(:all, :select => "positionname", :conditions => {:staff_id => sid}).map(&:positionname)
     end
     
   # <18/10/2011 - Shaliza fixed for the approver if staff no longer exists > 
   def subject_details
      suid = subject_id.to_a
      exists = Subject.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if subject_id == nil
        ""
      elsif checker == []
        "Subject No Longer Exists"
      else
        subject.subject_code_with_subject_name
      end
    end
    
     # <18/10/2011 - Shaliza fixed for the approver if staff no longer exists>
    def created_details
        suid = creator_id.to_a
        exists = Staff.find(:all, :select => "id").map(&:id)
        checker = suid & exists

        if creator_id == nil
          ""
        elsif checker == []
          "Staff No Longer Exists"
        else
          creator.mykad_with_staff_name
        end
    end
    
   # <18/10/2011 - Shaliza fixed for the approver if staff no longer exists >
    def approver_details
        suid = approvedby_id.to_a
        exists = Staff.find(:all, :select => "id").map(&:id)
        checker = suid & exists

        if approvedby_id == nil
          ""
        elsif checker == []
          "Staff No Longer Exists"
        else
          approver.mykad_with_staff_name
        end
    end
end
