class Studentcounselingsearch < ActiveRecord::Base
  attr_accessible :matrixno, :case_id
  attr_accessor :method
  
  def studentcounselings
    @studentcounselings ||= find_studentcounselings
  end
  
  private

  def find_studentcounselings
    StudentCounselingSession.find(:all, :conditions => conditions,  :order => orders)   
  end
  
  def matrixno_details
      a='student_id=? ' if  Student.find(:all, :conditions=>['matrixno=?',matrixno]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['matrixno=?',matrixno]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless matrixno.blank?
  end
  
  def matrixno_conditions
      [" ("+matrixno_details+")",Student.find(:all, :conditions=>['matrixno=?',matrixno]).map(&:id)] unless matrixno.blank?
  end
  
  def case_id_details
    a="case_id=?" if StudentDisciplineCase.all.map(&:id).uniq.count!=0
    0.upto(StudentDisciplineCase.all.map(&:id).uniq.count-2) do |l|  
      a=a+'OR case_id=? '
    end 
    return a 
  end 
  
  def case_id_conditions
      ["case_id is NOT NULL AND ("+case_id_details+")",StudentDisciplineCase.all.map(&:id)] 
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
