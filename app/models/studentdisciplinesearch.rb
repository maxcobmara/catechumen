class Studentdisciplinesearch < ActiveRecord::Base
  attr_accessible :name, :programme, :intake, :matrixno, :icno
  
  attr_accessor :method
  
  def studentdisciplines
    @studentdisciplines ||= find_studentdisciplines
  end
  
  private

  def find_studentdisciplines
    StudentDisciplineCase.find(:all, :conditions => conditions,  :order => orders)   
  end
  
  def programme_details
      a='student_id=? ' if  Student.find(:all, :conditions=>['course_id=?',programme]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['course_id=?',programme]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless programme.blank? 
  end

  def programme_conditions
    [" ("+programme_details+")", Student.find(:all, :conditions=>['course_id=?',programme]).map(&:id)] unless programme.blank?      
  end
  
   def intake_details
      a='student_id=? ' if  Student.find(:all, :conditions=>['intake=?',intake]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['intake=?',intake]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless intake.blank?
   end
   
   def intake_conditions
       [" ("+intake_details+")",Student.find(:all, :conditions=>['intake=?',intake]).map(&:id)] unless intake.blank?
       #[" ("+intake_details+")",Student.find(:all, :conditions=>['intake=?',"2011-09-01"]).map(&:id)] unless intake.blank?
   end
#   def intake_details
#      a='student_id=? ' if  Student.find(:all, :conditions=>['intake=? and course_id=?', intake, programme]).map(&:id).uniq.count!=0
#      0.upto( Student.find(:all, :conditions=>['intake=? and course_id=?', intake, programme]).map(&:id).uniq.count-2) do |l|  
#        a=a+'OR student_id=? '
#      end 
#      return a unless intake.blank? 
#   end
#   
#   def intake_conditions
#       [" ("+intake_details+")",Student.find(:all, :conditions=>['intake=? and course_id=?', intake, programme]).map(&:id)] unless intake.blank? 
#   end
  
  def matrixno_details
      a='student_id=? ' if  Student.find(:all, :conditions=>['matrixno=?',matrixno]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['matrixno=?',matrixno]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless matrixno.blank?
  end
  
  def matrixno_conditions
      [" ("+matrixno_details+")",Student.find(:all, :conditions=>['matrixno=?',matrixno]).map(&:id)] unless matrixno.blank? || Student.all.map(&:matrixno).include?(matrixno) == false || matrixno.length<9
  end
  
  def icno_details
      a='student_id=? ' if  Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless icno.blank?
  end
  
  def icno_conditions
      [" ("+icno_details+")",Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id)] unless icno.blank? || Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).count==0
  end
  
  def name_details
      a='student_id=? ' if  Student.find(:all, :conditions=>['name ILIKE ?',"%#{name}%"]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['name ILIKE ?',"%#{name}%"]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless name.blank?
  end
  
  def name_conditions
      [" ("+name_details+")",Student.find(:all, :conditions=>['name ILIKE ?',"%#{name}%"]).map(&:id)] unless name.blank? || Student.find(:all, :conditions=>['name ILIKE ?',"%#{name}%"]).count==0
      #["sender ILIKE ?","%#{sender}%" ] unless sender.blank? 
  end
  
#   def icno_details
#       a='student_id=? ' if Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id).uniq.count!=0
#       0.upto( Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id).uniq.count-2) do |l|  
#         a=a+'OR student_id=? '
#       end 
#       return a unless (icno.blank? && Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id).count==0)
#   end
#   
#   def icno_conditions
#       [" ("+icno_details+")",Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id)] unless (icno.blank? && Student.find(:all, :conditions=>['icno ILIKE ?',"%#{icno}%"]).map(&:id).count==0)
#   end
  
  
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
