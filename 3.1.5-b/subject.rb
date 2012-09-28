class Subject < ActiveRecord::Base
 
  validates_uniqueness_of :subjectcode, :message => " - This subject code has already been taken."
  
  has_and_belongs_to_many :programmes               #Link to HABTM programme_subject
  has_many :topics, :dependent => :destroy #, :class_name => 'Topic', :foreign_key => 'subject_id'   #Link to model topics
  #--10 May 2012 --
  has_many :question, :class_name => 'Examquestion', :foreign_key => 'curriculum_id', :dependent => :destroy
  #--10 May 2012 --
  #has_many :subject, :class_name => 'Examquestion', :foreign_key => 'curriculum_id', :dependent => :destroy#Link to model exam
  has_many :subjectevaluate, :class_name => 'Courseevaluation', :foreign_key => 'subject_id'#Link to model courseevaluation
  #has_many :time_table_entries, :dependent => :delete_all#Link to model timetableentry
  has_many :klasses
  
  #Link to Model Grade
  has_many :subjectgrade,  :class_name => 'Grade', :foreign_key => 'subject_id'
  
  #link to Exammaker - 26 June 2012(2 July 2012)
  has_many :examination, :class_name => 'Exammaker', :foreign_key => 'subject_id'

  def self.search(search)
    if search
      @subjects = Subject.find(:all, :conditions => ["subjectcode LIKE ? or name ILIKE ?", "%#{search}%","%#{search}%"])
    else
     @subjects = Subject.find(:all)
    end
  end
  
  #-------- 24 Apr 2012 ----------for search by programme
  def self.search2(search2)
    if search2 
        if search2 != '0'
           #@subjects = Subject.find(:all, :include => :programmes_subjects ,:conditions => ["programmes_subjects.programme_id=?", search2 ])
           @subjects = Programme.find(search2).subjects
        else
           #@subjects = Subject.find(:all, :order => 'name')
           @subjects = Subject.find(:all, :order=>'name').group_by { |t| t.semester }
        end
    else
        #@subjects = Subject.find(:all, :order => 'name')
        @subjects = Subject.find(:all, :order=>'name').group_by { |t| t.semester }
    end
  end
  #-------- 24 Apr 2012 ----------for search by programme
  
  
  def subject_code_with_subject_name
     "#{subjectcode}  #{name}"
  end
  
  def render_semester
    (Subject::SEMESTER.find_all{|disp, value| value == semester.to_s}).map {|disp, value| disp}
  end
  def render_status
    (Subject::STATUS.find_all{|disp, value| value == status.to_s}).map {|disp, value| disp}
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
