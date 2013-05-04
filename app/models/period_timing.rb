class PeriodTiming < ActiveRecord::Base
  #belongs_to intake
  belongs_to :intakename, :class_name => 'Intake', :foreign_key => 'intake_id'
  
  #Link to Model Timetableentry
  has_many :time_table_entries,  :class_name => 'Time_table_entry', :foreign_key => 'timing_id'
    
  
end