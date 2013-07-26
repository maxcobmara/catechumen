class Examsearch < ActiveRecord::Base
  attr_accessible :programme_id, :subject_id, :examtype, :created_by, :klass_id, :examdate  #klass_id for template vs complete paper
  attr_accessor :method
  
  def exams
    @exams ||= find_exams
  end
  
  private

  def find_exams
    Exam.find(:all, :conditions => conditions,  :order => orders)   
  end

  def subject_conditions
    ["subject_id=?", subject_id] unless subject_id.blank?      
  end
  
  def programme_id_details
    a='subject_id=? ' if Programme.find(programme_id).descendants.at_depth(2).map(&:id).uniq.count!=0
    0.upto(Programme.find(programme_id).descendants.at_depth(2).map(&:id).uniq.count-2) do |l|  
      a=a+'OR subject_id=? '
    end 
    return a unless programme_id.blank?
  end
  
  def programme_id_conditions
    ["( "+programme_id_details+")", Programme.find(programme_id).descendants.at_depth(2).map(&:id)] unless programme_id.blank?
  end
  
  def created_by_conditions
    ["created_by=?", created_by] unless created_by.blank?
  end
  
  def examtype_conditions
    ["name=?", examtype] unless examtype.blank?
  end
  
  def klass_id_conditions
    ["klass_id=?",klass_id] unless klass_id.blank?
  end
  
  def examdate_conditions
    ["exam_on=?",examdate] unless examdate.blank?
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
