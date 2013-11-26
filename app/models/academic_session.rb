class AcademicSession < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  
   has_many :semester_for_schedule, :class_name => 'WeeklyTimetable', :foreign_key => 'semester', :dependent => :nullify
end
