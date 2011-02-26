class Topic < ActiveRecord::Base
  
  before_save :save_my_vars
  
  belongs_to :subject#,   :class_name => 'Subject', :foreign_key => 'subject_id'
  belongs_to :creator,   :class_name => 'Staff',   :foreign_key => 'creator_id'
  belongs_to :approver,  :class_name => 'Staff',   :foreign_key => 'approvedby_id'
  
  validates_presence_of    :topic_code, :sequenceno, :name
  validates_uniqueness_of  :sequenceno, :scope => :subject_id, :message => 'This sequence is already taken'
  
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
end
