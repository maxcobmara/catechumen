class Examresultsearch < ActiveRecord::Base
  attr_accessible :programme_id, :subject_id, :student_id, :semester, :examdts, :examdte
  attr_accessor :method
  
  def examresults
    @examresults ||= find_examresults
  end
  
  private

  def find_examresults
    Examresult.find(:all, :conditions => conditions,  :order => orders)   
  end

  def programme_id_conditions
    ["programme_id=?", programme_id] unless programme_id.blank?      
  end
  
  def semester_conditions
    ["semester=?", semester] unless semester.blank?
  end
  
  def examdts_conditions
    ["examdts=?", examdts] unless examdts.blank?
  end
  
  def examdte_conditions
    ["examdte=?", examdte] unless examdte.blank?
  end
  
  def orders
    "examdts ASC"
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
