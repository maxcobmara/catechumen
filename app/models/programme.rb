class Programme < ActiveRecord::Base
  
  #Link to HABTM programme_subject
  has_and_belongs_to_many :subjects
  
  #Link to klassandstudent
  # has_and_belongs_to_many :klasses
  # has_and_belongs_to_many :students
  
  #links to Model student
   has_many :course,    :class_name => 'student', :foreign_key => 'course_id'
   
  #links to Model courseevaluation
  has_many :program,    :class_name => 'Courseevaluation', :foreign_key => 'programme_id'
  
  #links to Model courseevaluation
  has_many :programme,    :class_name => 'time_table_entry', :foreign_key => 'programme_id'
  
  #links to Model Klass
  has_many :programclass,    :class_name => 'klass', :foreign_key => 'programme_id'
  
  #links to Model evaluate_lecturer
  has_many :stucourse,    :class_name => 'evaluatelecturer', :foreign_key => 'course_id'
  
  #links to Model evaluate_lecturer
  has_many :course_coach,    :class_name => 'Evaluatecoach', :foreign_key => 'course_id'
  
  #links to Model analysis_result
  has_many :course_name,    :class_name => 'AnalysisGrade', :foreign_key => 'course_id'
  
  #links to Model analysispaperexam
  has_many :course,    :class_name => 'analysispaperexam', :foreign_key => 'course_id'
  
  #links to Model exammaker
  has_many :course_exam,    :class_name => 'Exammaker', :foreign_key => 'course_id'
  
  #links to Model exammaker
  has_many :studentattendances

  COURSETYPE = [
      #  Displayed       stored in db
      [ "Asas",             "Asas" ],
      [ "Pertengahan",      "Pertengahan" ],
      [ "Lanjutan",         "Lanjutan" ]
    ]
   
  #15/11/2011 - Shaliza added for combination name and specialisation
    def programme_with_specialisation
      "#{name} - #{specialisation}"
    end
   
  attr_accessible :code, :name, :specialisation
  attr_accessible :subject_ids
end
