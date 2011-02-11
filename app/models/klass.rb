class Klass < ActiveRecord::Base
  
  #Link to Model Timetableentry
   has_many :klass,  :class_name => 'TimeTableEntry', :foreign_key => 'klass_id'
   
  #Link to Model Intake
     belongs_to :intakeclass,  :class_name => 'Intake', :foreign_key => 'intake_id'
     
  #Link to Model Programme
  belongs_to :programmeclass,  :class_name => 'Programme', :foreign_key => 'programme_id'
  
  
  #Link to student
   has_and_belongs_to_many :students
   #has_and_belongs_to_many :programmes
   
   attr_accessible :intake_id
end
