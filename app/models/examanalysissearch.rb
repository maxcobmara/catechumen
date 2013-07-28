class Examanalysissearch < ActiveRecord::Base
  attr_accessible :examtype, :subject_id, :examon, :exampaper, :programme_id
  attr_accessor :method
  
  def examanalyses
    @examanalyses ||= find_examanalyses
  end
  
  private

  def find_examanalyses
    Examanalysis.find(:all, :conditions => conditions,  :order => orders)   
  end

  #def exampaper_conditions
    #["exam_id=?", exampaper] unless exampaper.blank?      
  #end

	def subject_id_details
	    a='exam_id=? ' if Exam.find(:all, :conditions=>['subject_id=?',subject_id]).map(&:id).uniq.count!=0
      0.upto(Exam.find(:all, :conditions=>['subject_id=?',subject_id]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR exam_id=? '
      end 
      return a unless subject_id.blank?
	end
	 
  def subject_id_conditions
    [" ("+subject_id_details+")", Exam.find(:all, :conditions=>['subject_id=?',subject_id]).map(&:id)] unless subject_id.blank?      
  end
  
  #----
  def programme_id_details
	    a='exam_id=? ' if Exam.find(:all, :conditions=>['subject_id IN(?)',Programme.find(programme_id).descendants.at_depth(2).map(&:id)]).map(&:id).uniq.count!=0
      0.upto(Exam.find(:all, :conditions=>['subject_id IN(?)',Programme.find(programme_id).descendants.at_depth(2).map(&:id)]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR exam_id=? '
      end 
      return a unless programme_id.blank?
	end
  
  def programme_id_conditions
    [" ("+programme_id_details+")", Exam.find(:all, :conditions=>['subject_id IN(?)',Programme.find(programme_id).descendants.at_depth(2).map(&:id)]).map(&:id)] unless programme_id.blank?     
  end 
  #----
  
  def examtype_details
      a='exam_id=? ' if Exam.find(:all, :conditions=>['name=?',examtype]).map(&:id).uniq.count!=0
      0.upto(Exam.find(:all, :conditions=>['name=?',examtype]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR exam_id=? '
      end 
      return a unless examtype.blank?
  end
  
  def examtype_conditions
    [" ("+examtype_details+")", Exam.find(:all, :conditions=>['name=?',examtype]).map(&:id) ] unless examtype.blank?
  end
  
  def examon_details
	    a='exam_id=? ' if Exam.find(:all, :conditions=>['exam_on=?',examon]).map(&:id).uniq.count!=0
      0.upto(Exam.find(:all, :conditions=>['exam_on=?',examon]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR exam_id=? '
      end 
      return a if (Exam.find(:all, :conditions=>['exam_on=?',examon]).map(&:id).uniq.count!=0) #unless examon.blank? && Exam.find_by_exam_on(examon).count==0
	end
  
  def examon_conditions
    [" ("+examon_details+")", Exam.find(:all, :conditions=>['exam_on=?',examon]).map(&:id)] if (Exam.find(:all, :conditions=>['exam_on=?',examon]).map(&:id).uniq.count!=0)#unless examon.blank? && Exam.find_by_exam_on(examon).count==0     
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
