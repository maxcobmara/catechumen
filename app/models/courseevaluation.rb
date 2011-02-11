class Courseevaluation < ActiveRecord::Base
  
  belongs_to :studentevaluate, :class_name => 'Student', :foreign_key => 'student_id'
  belongs_to :program, :class_name => 'Programme', :foreign_key => 'programme_id'
  belongs_to :subjectevaluate, :class_name => 'Subject', :foreign_key => 'subject_id' 
end
