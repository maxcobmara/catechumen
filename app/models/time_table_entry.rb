class TimeTableEntry < ActiveRecord::Base
  
  validates_presence_of :subject, :topic
  
  #belongs_to intake_id
  belongs_to :intake, :class_name => 'Intake', :foreign_key => 'intake_id'
  
  #belongs_to programme_id
  belongs_to :programme, :class_name => 'Programme', :foreign_key => 'programme_id'
  
  #belongs_to subject_id
  belongs_to :subject
   
  #belongs_to topic_id
  belongs_to :topic, :class_name => 'Topic', :foreign_key => 'topic_id'
    
  #belongs_to klass_id
  belongs_to :klasstime, :class_name => 'Klass', :foreign_key => 'klass_id'
  
  #belongs_to staff_id
  belongs_to :timetable, :class_name => 'Staff', :foreign_key => 'staff_id'
  
  #belongs_to period_timing_id
  belongs_to :period_timing, :class_name => 'PeriodTiming', :foreign_key => 'timing_id'
  
  #belongs_to residence
  belongs_to :residence, :class_name => 'Residence', :foreign_key => 'residence_id'
  
  belongs_to :timetable_week_day
  
WEEK_DAY = [
        #  Displayed       stored in db
        [ "Isnin","1" ],
        [ "Selasa","2" ],
        [ "Rabu", "3" ],
        [ "Khamis", "4"],
        [ "Jumaat", "5"]
   ]
   
LOCATION = [
           #  Displayed       stored in db
        [ "Pusat Latihan","1" ],
        [ "Akademi","2" ]
      ]

   def matrix_a1
     "A1"
   end
   
    def subject_details 
          suid = subject_id.to_a
          exists = Subject.find(:all, :select => "id").map(&:id)
          checker = suid & exists     

          if subject_id == nil
             "" 
           elsif checker == []
             "Subject No Longer Exists" 
          else
            subject.subject_code_with_subject_name
          end
     end
     
    def programme_details 
        suid = programme_id.to_a
        exists = Programme.find(:all, :select => "id").map(&:id)
        checker = suid & exists     

        if programme_id == nil
          "" 
        elsif checker == []
        "Subject No Longer Exists" 
        else
          programme.name
      end
    end

   
end
