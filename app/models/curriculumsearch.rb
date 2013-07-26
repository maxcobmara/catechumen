class Curriculumsearch < ActiveRecord::Base
  attr_accessible :programme_id, :semester, :subject, :topic
  attr_accessor :method
  
  def curriculums
    @curriculums ||= find_curriculums
  end
  
  private

  def find_curriculums
    Programme.find(:all, :conditions => conditions,  :order => orders)   
  end

  def programme_id_conditions
    ["ancestry_depth=?", 0] unless programme_id==0    #if programme_id==1    
  end
  
  def semester_conditions
    ["ancestry_depth=?",1] unless semester==0
  end
  
  def subject_conditions
    ["ancestry_depth=?", 2] unless subject==0
  end
  
  def topic_conditions
    ["ancestry_depth=?", 3] unless topic==0
  end  
  
  def orders
    "id ASC"
  end  

  def conditions  #Use OR operator instead of AND operator
    [conditions_clauses.join(' OR '), *conditions_options] 
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
