class Intake < ActiveRecord::Base
 #Link to Period_timing
  has_many :intakename,        :class_name => 'period_timing', :foreign_key => 'intake_id'
  
  #Link to Time Table Entry
  has_many :intake,        :class_name => 'time_table_entry', :foreign_key => 'intake_id'
  
  #Link to Class
  has_many :intakeclass,        :class_name => 'klass', :foreign_key => 'intake_id'
  
  #Link to Student
  has_many :intakestudent,        :class_name => 'Student', :foreign_key => 'intake_id'


#---------------------validations-----------------------------------

validates_presence_of  :name, :intake_no, :year

end