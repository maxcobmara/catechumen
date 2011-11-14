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

     #<18/10/2011 - Shaliza fixed error for timing >
     def timing_start_details 
           suid = timing_id.to_a
           exists = PeriodTiming.find(:all, :select => "id").map(&:id)
           checker = suid & exists     

           if timing_id == nil
              "" 
            elsif checker == []
              "Timing No Longer Available" 
           else
             period_timing.start_time
           end
      end
      
      #<18/10/2011 - Shaliza fixed error for timing >
      def timing_end_details 
             suid = timing_id.to_a
             exists = PeriodTiming.find(:all, :select => "id").map(&:id)
             checker = suid & exists     

             if timing_id == nil
                "" 
              elsif checker == []
                "Timing No Longer Available" 
             else
               period_timing.end_time
             end
        end
        
        #<18/10/2011 - Shaliza fixed error if staff does not have position >
        def staff_details 
               suid = staff_id.to_a
               exists = Staff.find(:all, :select => "id").map(&:id)
               checker = suid & exists     

               if staff_id == nil
                  "" 
                elsif checker == []
                  "Staff No Longer Exists" 
               else
                 timetable.staff_name_with_position
               end
        end
        
        
   
end
