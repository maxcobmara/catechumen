class Subject < ActiveRecord::Base
 
  #Link to HABTM programme_subject
  has_and_belongs_to_many :programmes
  
  #Link to model topics
  has_many :topics#, :class_name => 'Topic', :foreign_key => 'subject_id'  
  
  #Link to model exam
  has_many :subject, :class_name => 'Examquestion', :foreign_key => 'curriculum_id', :dependent => :destroy
  
  #Link to model exammaker
  has_many :subjectexamination, :class_name => 'Exammaker', :foreign_key => 'subject_id'
  
  #Link to Model Grade
  has_many :subjectgrade, :class_name => 'Grade', :foreign_key => 'subject_id'
  
  #Link to model courseevaluation
  has_many :subjectevaluate, :class_name => 'Courseevaluation', :foreign_key => 'subject_id'
  
  #Link to model timetableentry
  has_many :time_table_entries, :dependent => :delete_all
  
  
  
  #Link to Model evaluate_lecturer
  has_many :subjectevaluate,  :class_name => 'evaluate_lecturer', :foreign_key => 'subject_id'
  
  #Link to Model evaluate_coach
  has_many :subjectcoachev,  :class_name => 'evaluate_coach', :foreign_key => 'subject_id'
  
  #links to Model klass
  has_many :subjectclass,    :class_name => 'Klass', :foreign_key => 'subject_id'
  
  def subject_code_with_subject_name
     "#{subjectcode} - #{name}"
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
   @subjects = Subject.find(:all, :order => 'name ASC')
  end
end   
     
end
