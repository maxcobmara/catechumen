class Studentcounselingsearch < ActiveRecord::Base
  attr_accessible :matrixno, :case_id, :confirmed_at_start, :confirmed_at_end, :is_confirmed, :name
  attr_accessor :method
  
  def studentcounselings
    @studentcounselings ||= find_studentcounselings
  end
  
  private

  def find_studentcounselings
    StudentCounselingSession.find(:all, :conditions => conditions,  :order => orders)   
  end
  
  def matrixno_details
      a='student_id=? ' if  Student.find(:all, :conditions=>['matrixno ILIKE(?)',"%#{matrixno}%"]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['matrixno ILIKE(?)',"%#{matrixno}%"]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless matrixno.blank?
  end
  
  def matrixno_conditions
      [" ("+matrixno_details+")",Student.find(:all, :conditions=>['matrixno ILIKE(?)',"%#{matrixno}%"]).map(&:id)] unless matrixno.blank?
  end
  
  def name_details
     a='student_id=? ' if  Student.find(:all, :conditions=>['name ILIKE(?)',"%#{name}%"]).map(&:id).uniq.count!=0
      0.upto( Student.find(:all, :conditions=>['name ILIKE(?)',"%#{name}%"]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR student_id=? '
      end 
      return a unless name.blank?
  end
  
  def name_conditions
    [" ("+name_details+")",Student.find(:all, :conditions=>['name ILIKE(?)',"%#{name}%"]).map(&:id)] unless name.blank?
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
  
  def is_confirmed_conditions
    ["is_confirmed=?", is_confirmed] unless is_confirmed.blank?
  end
  
  def confirmed_at_start_conditions
    ["confirmed_at>=?", confirmed_at_start] unless confirmed_at_start.blank?
  end  
  
  def confirmed_at_end_conditions
    ["confirmed_at<=?", confirmed_at_end+16.hours] unless confirmed_at_end.blank?  #dd-mm-yy 00:00 - to add 24 hours (1 day) but deduct 8.hours (time zone?)
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
