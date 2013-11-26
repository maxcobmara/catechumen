class Staffsearch2 < ActiveRecord::Base
  attr_accessible :keywords, :position, :staff_grade

  
  def staffs
    @staffs ||= find_staffs
  end
  
  private

  def find_staffs
    Staff.find(:all, :conditions => conditions,  :order => orders)    # :order => "staffgrade_id ASC "
  end

  def keyword_conditions
    ["staffs.name ILIKE ?", "%#{keywords}%"] unless keywords.blank?   #["staffgrade.name ILIKE ?", "%#{keywords}%"] unless keywords.blank?#
  end
  
  def gra
    #Bersepadu (4)
    return "staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=?" if position == 4 
    #Sokongan (2)
    return "staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=?" if position == 2
    #Pengurusan & Profesional (1)
    return "staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=?" if position == 1
  end 
  
  def position_conditions 
      [gra,Employgrade.find(:all,:conditions=>['group_id=?',position]).map(&:id) ] unless position.blank?
      
      #yg OK2----
      #[gra,[1, 2, 3, 4, 5, 19, 20, 21, 22, 23, 24, 25, 26, 27, 48, 49, 50, 51, 52, 59, 60, 61, 62, 63] ] unless position.blank?
      
      #yg OK---
      #["staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=? OR staffgrade_id=?",1, 2, 3, 4, 5, 19, 20, 21, 22, 23, 24, 25, 26, 27, 48, 49, 50, 51, 52, 59, 60, 61, 62, 63 ] unless position.blank?
      
  end

  def staffgrade_conditions
    ["staffgrade_id =?", staff_grade] unless staff_grade.blank?
  end
  
  #def category_conditions
    #["staffs.category_id = ?", category_id] unless category_id.blank?
  #end
  
  def orders
   "staffgrade_id ASC"
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
