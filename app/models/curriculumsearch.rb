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
    ["id=?", programme_id] unless programme_id.blank?
  end
  
  def semester_conditions
    ["id=?", semester] unless semester.blank?
  end
  
  def subject_conditions
    descendants_ids = Programme.find(semester).descendants.map(&:id)
    subjects_ids = Programme.find(:all, :conditions => ['id IN(?) and course_type=?', descendants_ids, 'Subject'])
    if subjects_ids.count > 0
      a="id=?"
      0.upto(subjects_ids.count-2).each do |y|
        a+=" OR id=? " if subjects_ids.count > 1
      end
      [a, subjects_ids] if !semester.blank? && subject==1 && subjects_ids.count > 0
    end
  end
  
  def topic_conditions
    descendants_ids = Programme.find(semester).descendants.map(&:id)
    topics_ids = Programme.find(:all, :conditions => ['id IN(?) and (course_type=? or course_type=?)', descendants_ids, 'Topic', 'Subtopic'])
    if topics_ids.count > 0
      a="id=?"
      0.upto(topics_ids.count-2).each do |y|
        a+=" OR id=? " if topics_ids.count
      end
      [a, topics_ids] if !semester.blank? && subject==1 && topic==1
    end
  end  
  
  def orders
    "combo_code ASC"
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
