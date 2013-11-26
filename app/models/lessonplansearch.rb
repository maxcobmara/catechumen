class Lessonplansearch < ActiveRecord::Base
  attr_accessible :lecturer, :intake_id, :programme_id, :intake
  attr_accessor :method
  
  def lessonplans
     @lessonplans ||= find_lessonplans
   end

   private

   def find_lessonplans
     LessonPlan.find(:all, :conditions => conditions,  :order => orders)   
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
    "topic ASC"
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
