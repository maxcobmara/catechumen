class Studentsearch < ActiveRecord::Base
  attr_accessible :icno, :name, :matrixno, :sstatus, :ssponsor,   :course_id, :physical, :end_training, :intake, :gender, :race, :bloodtype#, :end_training2
  #attr_accessible :mrtlstatuscd,
  attr_accessor :method
  
  def students
    @students ||= find_students
  end
  
  private

  def find_students
    Student.find(:all, :conditions => conditions,  :order => orders)   
  end

  def icno_conditions 
    ["icno ILIKE ?","%#{icno}%" ] unless icno.blank? 
  end
  
  def name_conditions 
    ["name ILIKE ?","%#{name}%" ] unless name.blank? 
  end
  
  def matrixno_conditions 
    ["matrixno ILIKE ?","%#{matrixno}%" ] unless matrixno.blank? 
  end
  
  #def sstatus_conditions 
    #["sstatus =?",sstatus] unless sstatus.blank? 
  #end
  
  def gender_conditions 
     ["gender=?",gender] unless gender.blank? 
  end
  
  def race_conditions 
     ["race2=?",race] unless race.blank? 
  end

  def ssponsor_conditions 
    ["ssponsor =?", ssponsor] unless ssponsor.blank? 
  end
  
  #def mrtlstatuscd_conditions 
    #["mrtlstatuscd =?",mrtlstatuscd] unless mrtlstatuscd.blank? 
  #end
  
  def course_id_details
      a='id=? ' if Student.find(:all,:conditions=>['course_id=?',course_id]).map(&:id).uniq.count!=0
      0.upto(Student.find(:all,:conditions=>['course_id=?',course_id]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR id=? '
      end 
      return a unless course_id.blank?
  end
  
  def course_id_conditions 
    #["course_id =?",course_id] unless course_id.blank? 
    [" ("+course_id_details+")", Student.find(:all,:conditions=>['course_id=?',course_id]).map(&:id)] unless course_id.blank?
  end
  
  def physical_conditions 
    ["physical ILIKE ?","%#{physical}%" ] unless physical.blank? 
  end
  
  def bloodtype_conditions 
    ["bloodtype =?",bloodtype] unless bloodtype.blank? 
  end  

#   def race_conditions 
#     ["race ILIKE ?","%#{race}%"] unless race.blank? 
#   end

 def intake_conditions
   ["intake=?", intake] unless intake.blank?
   #["intake=?", intake] unless intake.blank?
   #["students.intake>=? AND intake<?", intake, intake+1.day] unless intake.blank?
 end

  def end_training_conditions
    ["end_training=? ", end_training] unless end_training.blank?
    #["end_training>=? AND end_training<?", end_training, end_training+1.day] unless end_training.blank?
  end

  #def end_training2_conditions
   # ["end_training<?", end_training2] unless end_training2.blank?
    ##["end_training>=? AND end_training<?", end_training, end_training+1.day] unless end_training.blank?
  #end

  def orders
    "intake, matrixno ASC"
    # "course_id, intake, matrixno ASC"
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
