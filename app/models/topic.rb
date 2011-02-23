class Topic < ActiveRecord::Base
  #belongs_to :subject
  #belongs_to :staff
  
  belongs_to :subject,   :class_name => 'Subject', :foreign_key => 'subject_id'
  belongs_to :tcreator,  :class_name => 'Staff',   :foreign_key => 'creator_id'
  belongs_to :approvertopic,  :class_name => 'Staff',   :foreign_key => 'approvedby_id'
  
  #Link to Model Timetableentry
  #has_many :topic,  :class_name => 'Time_table_entry', :foreign_key => 'topic_id'
  
  def self.find_main
    Topic.find(:all, :condition => ['topic_id IS NULL'])
  end
  
  #validates_presence_of    :topic_code, :sequenceno, :name
  #validates_uniqueness_of  :topic_and_sequence, :message => 'This sequence is already taken'
  
  #def self.find_main
     #Subject.find(:all, :condition => ['subject_id IS NULL'])
   #end
   
   #def self.find_main
     #Staff.find(:all, :condition => ['creator_id IS NULL'])
   #end
  
  #def topic_and_sequence
    #{}"#{topic_code}  #{sequenceno}"
  #end
  
  #def self.search(search)
     #if search
      #@topic = Topic.find(:all, :conditions => ["name LIKE ? or topic_code ILIKE ?", "%#{search}%","%#{search}%"], :order => :topic_code)
     #else
      #@topic = Topic.find(:all,  :order => :topic_code)
     #end
  #end
end
