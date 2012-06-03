class Subject < ActiveRecord::Base
 
  
  has_and_belongs_to_many :programmes               #Link to HABTM programme_subject
  has_many :topics, :dependent => :destroy #, :class_name => 'Topic', :foreign_key => 'subject_id'   #Link to model topics
  #has_many :subject, :class_name => 'Examquestion', :foreign_key => 'curriculum_id', :dependent => :destroy#Link to model exam
  has_many :subjectevaluate, :class_name => 'Courseevaluation', :foreign_key => 'subject_id'#Link to model courseevaluation
  #has_many :time_table_entries, :dependent => :delete_all#Link to model timetableentry
  has_many :klasses
  
  #Link to Model Grade
  has_many :subjectgrade,  :class_name => 'Grade', :foreign_key => 'subject_id'
  
  def self.search(search)
    if search
      @subjects = Subject.find(:all, :conditions => ["subjectcode LIKE ? or name ILIKE ?", "%#{search}%","%#{search}%"])
    else
     @subjects = Subject.find(:all)
    end
  end
  
  
  
  
  def subject_code_with_subject_name
     "#{subjectcode}  #{name}"
  end
  
  
    
SEMESTER = [
            #  Displayed       stored in db
            [ "Tahun 1/Semester I","1" ],
            [ "Tahun 1/Semester II","2" ],
            [ "Tahun 2/Semester I","3" ],
            [ "Tahun 2/Semester II","4" ],
            [ "Tahun 3/Semester I","5" ],
            [ "Tahun 3/Semester II","6" ],
            
]


STATUS = [
                #  Displayed       stored in db
                [ "Major","1" ],
                [ "Minor","2" ],
                [ "Elective","3" ]

    ]
    
     
end
