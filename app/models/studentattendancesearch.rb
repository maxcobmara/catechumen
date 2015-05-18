class Studentattendancesearch < ActiveRecord::Base
  attr_accessible :schedule_id, :intake_id, :student_id
  attr_accessor :method
  
  def studentattendances
    @studentattendances ||= find_studentattendances
  end
  
  private

  def find_studentattendances
    StudentAttendance.find(:all, :conditions => conditions,  :order => orders)   
  end

  def schedule_id_conditions
    ["weeklytimetable_details_id=?", schedule_id] unless schedule_id.blank?      
  end

  def intake_id_details
      a='student_id=? ' if Student.find(:all, :conditions=>['intake=?',Intake.find(intake_id).monthyear_intake]).map(&:id).uniq.count!=0
      0.upto(Student.find(:all, :conditions=>['intake=?',Intake.find(intake_id).monthyear_intake]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless intake_id.blank?
  end  
  
  def intake_id_conditions
    [intake_id_details, Student.find(:all, :conditions=>['intake=?',Intake.find(intake_id).monthyear_intake]).map(&:id)] unless intake_id.blank?
  end
  
  def student_id_conditions
    ["student_id=?",Student.find(:first, :conditions=>['matrixno=?',student_id.to_s]).id] unless student_id.blank?    #matrixno (in STUDENT table)
    #["student_id=?",student_id] unless student_id.blank?   #student_id (in STUDENT table)
  end
 
  def orders
    "id ASC"
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
