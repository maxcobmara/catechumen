class Lessonplansearch < ActiveRecord::Base
  attr_accessible :lecturer, :intake_id, :programme_id, :intake, :valid_schedule, :subject, :loggedin_staff
  attr_accessor :method
  
  def lessonplans
     @lessonplans ||= find_lessonplans
  end
   

   private

   def find_lessonplans
     LessonPlan.find(:all, :conditions => conditions,  :order => orders)   
   end
   
   def loggedin_staff_details
     if loggedin_staff==0         
       all_lecturers = LessonPlan.all.map(&:lecturer)
       a=" lecturer=? " if all_lecturers.count > 0
       0.upto(all_lecturers.count-2).each do |cnt|
         a+=" OR lecturer=? "
       end
       b=["("+a+")", all_lecturers] 
     else
       if loggedin_staff.to_s.size > 3
         comb_staff = loggedin_staff.to_s
         progid=(comb_staff[3, comb_staff.size]).to_i
         all_intakes = LessonPlan.all.map(&:intake_id)
         intakes_of_prog = Intake.find(:all, :conditions => ['id IN(?) and programme_id=?',all_intakes, progid]).map(&:id)
         a=" intake_id=? " if intakes_of_prog.count > 0
         0.upto(intakes_of_prog.count-2).each do |cnt|
           a+=" OR intake_id=? "
         end
         b=["("+a+")", intakes_of_prog]
       else
         b=["lecturer=?", loggedin_staff]
       end
     end
     return b unless loggedin_staff.blank?
   end
   
   def loggedin_staff_conditions
     loggedin_staff_details unless loggedin_staff.blank?
   end
   
   def valid_schedule_conditions
     valid_schedule_ids = WeeklytimetableDetail.valid_sch_ids
     if valid_schedule_ids.count > 0
       a=" schedule=? " if valid_schedule_ids.count > 0
       0.upto(valid_schedule_ids.count-2).each do |cnt|
         a+=" OR schedule=? "
       end
       ["("+a+")", valid_schedule_ids] if valid_schedule == 1
     end
   end 

   def programme_details
       a='topic=? ' if (Programme.find(programme_id).descendants.at_depth(4)+Programme.find(programme_id).descendants.at_depth(3)).map(&:id).uniq.count!=0
        0.upto((Programme.find(programme_id).descendants.at_depth(4)+Programme.find(programme_id).descendants.at_depth(3)).map(&:id).uniq.count-2) do |l|  
          a=a+'OR topic=? '
        end 
        return a if !programme_id.blank? && intake != '1'  #unless file_id.blank?
   end   

   def programme_conditions
     ##["programme_id=?",programme_id] if !programme_id.blank? && intake != '1'    
     [" ("+programme_details+")",(Programme.find(programme_id).descendants.at_depth(4)+Programme.find(programme_id).descendants.at_depth(3)).map(&:id)] if !programme_id.blank? && intake != '1'  
   end

   def intake_id_conditions
     ["intake_id=?", intake_id] if !intake_id.blank? && intake != '0'            #if intake != 0 ##unless intake_id.blank? && intake != 1   #intake_id exist & intake must 1  
   end

   def lecturer_conditions
     ["lecturer=?", lecturer] unless lecturer.blank?      
   end
  
  def orders
    #"intake_id ASC"
  end  

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options] #works like OR?????
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
  
end
