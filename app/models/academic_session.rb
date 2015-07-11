class AcademicSession < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
   
   before_destroy :valid_for_removal
   has_many :semester_for_schedules, :class_name => 'Weeklytimetable', :foreign_key => 'semester'
   validates_numericality_of :total_week
   
   private
   
   def valid_for_removal
     if semester_for_schedules.count > 0
       return false
     else
       return true
     end
   end
   
end
