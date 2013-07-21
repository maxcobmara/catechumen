class Staffsearch < ActiveRecord::Base
  
  def staffs
    @staffs ||= find_staffs
  end
  
  private

  def find_staffs
    Staff.find(:all, :conditions => conditions)
  end

  def keyword_conditions
    ["staffs.name LIKE ?", "%#{keywords}%"] unless keywords.blank?
  end

  def position_conditions #try using id first
    ["staffs.id =?", position] unless position.blank?
  end

  def staffgrade_conditions
    ["staffs.staffgrade_id =?", staff_grade] unless staff_grade.blank?
  end

  #def category_conditions
    #["staffs.category_id = ?", category_id] unless category_id.blank?
  #end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
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
