class Examsearch < ActiveRecord::Base
  attr_accessible :programme_id, :subject_id, :examtype, :created_by, :klass_id, :examdate, :valid_papertype
  attr_accessor :method
  
  def exams
    @examsearch ||= find_exams
  end
  
  private

  def find_exams
    Exam.find(:all, :conditions => conditions,  :order => orders)   
  end
  
   def valid_papertype_conditions
     ["klass_id is not null"] unless valid_papertype.blank?
   end
   
   def programme_id_conditions
     unless programme_id.blank?
       subject_ids_in_exams = Exam.find(:all, :conditions =>['klass_id is not null']).map(&:subject_id)
       prog_descendants=Programme.find(programme_id).descendants.map(&:id)
       subject_ids = Programme.find(:all, :conditions => ['id IN(?) and id IN(?)', subject_ids_in_exams, prog_descendants]).map(&:id)
       a="subject_id=? " if subject_ids.count > 0
       0.upto(subject_ids.count-2).each do |x|
         a+=" OR subject_id=? " 
       end
     end
     ["("+a+")", subject_ids] unless programme_id.blank?  
   end
  
   def subject_id_conditions
     ["subject_id=?", subject_id] unless subject_id.blank?
   end
  
   def examtype_conditions
     ["name=?", examtype] unless examtype.blank?
   end
   
   def created_by_conditions
     ["created_by=?", created_by] unless created_by.blank?
   end
   
   def klass_id_conditions
     ["klass_id=?", klass_id] unless klass_id.blank?
   end
   
   def examdate_conditions
     ["exam_on=?", examdate] unless examdate.blank?
   end
  
  def orders
    "exam_on DESC"
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
