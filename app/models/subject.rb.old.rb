class Subject < ActiveRecord::Base
 
  #Link to HABTM programme_subject
  has_and_belongs_to_many :programmes
  
  #Link to model topics
  has_many :topics#, :class_name => 'Topic', :foreign_key => 'subject_id'  
  
  #Link to model exam
  has_many :subject, :class_name => 'Examquestion', :foreign_key => 'curriculum_id', :dependent => :destroy
  
  #Link to model courseevaluation
  has_many :subjectevaluate, :class_name => 'Courseevaluation', :foreign_key => 'subject_id'
  
  #Link to model timetableentry
  has_many :time_table_entries, :dependent => :delete_all
  
  #Link to Model Grade
  has_many :subjectgrade,  :class_name => 'Grade', :foreign_key => 'subject_id'
  
  
  def subject_code_with_subject_name
     "#{subjectcode}  #{name}"
   end
  
  
    
STATUS = [
            #  Displayed       stored in db
            [ "Major","1" ],
            [ "Minor","2" ],
            [ "Elective","3" ]
            
]

def self.search(search)
  if search
    @subjects = Subject.find(:all, :conditions => ["subjectcode LIKE ? or name ILIKE ?", "%#{search}%","%#{search}%"])
  else
   @subjects = Subject.find(:all)
  end
end   
     
end
