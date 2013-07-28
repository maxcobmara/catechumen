class Evaluatecoursesearch < ActiveRecord::Base
  attr_accessible :programme_id, :subject_id, :evaldate, :lecturer_id
  attr_accessor :method
  
  def evaluatecourses
    @evaluatecourses ||= find_evaluatecourses
  end
  
  private

  def find_evaluatecourses
    EvaluateCourse.find(:all, :conditions => conditions,  :order => orders)   
  end

  def programme_id_conditions
    ["course_id=?", programme_id] unless programme_id.blank?      
  end
  
  def subject_id_conditions
    ["subject_id=?", subject_id] unless subject_id.blank?      
  end
  
  def evaldate_conditions
    ["evaluate_date=?", evaldate] unless evaldate.blank?      
  end
  
  def lecturer_id_conditions
    ["staff_id=?", lecturer_id] unless lecturer_id.blank?      
  end
  
  def orders
     "course_id, subject_id, evaluate_date, staff_id ASC"
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
