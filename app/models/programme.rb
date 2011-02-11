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
  has_many :programclass,    :class_name => 'Klass', :foreign_key => 'programme_id'
  
   
  def programme_code_with_programme_name
     "#{code}  #{name}"
   end 
   
  attr_accessible :code, :name, :specialisation
  attr_accessible :subject_ids
end
