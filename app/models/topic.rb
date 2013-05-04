class Topic < ActiveRecord::Base
  
  before_save :save_my_vars
  has_many :timetables
  has_many :examquestions
  
  has_many :trainingreports
   
  belongs_to :subject#,   :class_name => 'Subject', :foreign_key => 'subject_id'
  belongs_to :creator,   :class_name => 'Staff',   :foreign_key => 'creator_id'
  belongs_to :approver,  :class_name => 'Position',   :foreign_key => 'approvedby_id'
  belongs_to :class_plan,  :class_name => 'Klass',   :foreign_key => 'class_id'
  belongs_to :loc_plan, :class_name => 'Location', :foreign_key => 'location_id'
  
  validates_presence_of    :topic_code, :sequenceno, :name
  validates_uniqueness_of  :sequenceno, :scope => :subject_id, :message => 'This sequence is already taken'
  
  has_many :training_notes, :dependent => :destroy
  accepts_nested_attributes_for :training_notes, :reject_if => lambda { |a| a[:title].blank? }
   
  has_many :lesson_plans, :dependent => :destroy
  accepts_nested_attributes_for :lesson_plans, :reject_if => lambda { |a| a[:objective].blank? }
   
 #  attr_accessible :timing, :objective, :task, :tool

  def topic_subject
     "#{subject_topic} - #{name}"
  end
  
  def subject_topic
     suid = subject_id.to_a
     exists = Subject.find(:all, :select => "id").map(&:id)
     checker = suid & exists

     if subject_id == nil
       ""
     elsif checker == []
       "N/A"
     else
       subject.name
     end
   end
  

  #Link to Model Timetableentry
  #has_many :topic,  :class_name => 'Time_table_entry', :foreign_key => 'topic_id'
  
  def self.find_main
    Topic.find(:all, :condition => ['topic_id IS NULL'])
  end
  
  def save_my_vars
    self.duration	= make_minutes
    
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
       suid = subject.id
       Subject.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
   end
  
   
   def staff_position
     sid = staff.id
     Position.find(:all, :select => "positionname", :conditions => {:staff_id => sid}).map(&:positionname)
   end
   

    def created_details
        suid = creator_id.to_a
        exists = Staff.find(:all, :select => "id").map(&:id)
        checker = suid & exists

        if creator_id == nil
          ""
        elsif checker == []
          "Staff No Longer Exists"
        else
          creator.staff_name_with_title
        end
    end
    
    def approver_details
        suid = approvedby_id.to_a
        exists = Position.find(:all, :select => "id").map(&:id)
        checker = suid & exists

        if approvedby_id == nil
          ""
        elsif checker == []
          "Staff No Longer Exists"
        else
          approver.unit_staff_name
        end
    end
    
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

#---------------Search--------------------------------------------------------------------------------

def self.search(search)
  if search
     @topic = Topic.find(:all, :conditions => ["topic_code ILIKE ? or name ILIKE ?", "%#{search}%","%#{search}%"])
  else
     @topic = Topic.find(:all, :order => 'sequenceno', :limit => 50)
  end
end

end
