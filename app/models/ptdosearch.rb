class Ptdosearch < ActiveRecord::Base
  attr_accessible :attended_courses, :staff_name, :staff_id, :icno, :schedulestart_start , :schedulestart_end  #:department      WORKING : Department part - hide 29April2015
  attr_accessor :method
  
  def ptdos
    @ptdos ||= find_ptdos
  end
  
  private

  def find_ptdos
    Ptdo.find(:all, :conditions => conditions,  :order => orders)   
  end
 
  def attended_courses_conditions
   ['(final_approve is true AND trainee_report is not null)',] if attended_courses==1
  end
  
#WORKING : Department part - hide 29April2015
#   def department_conditions
#     progdip_name=Programme.find(:all, :conditions => ['course_type=?', 'Diploma']).map(&:name)
#     other_dept=Position.find(:all, :conditions => ['unit is not null and unit NOT IN (?) and unit NOT IN (?)', ['Diploma Lanjutan', 'Pos Basik', 'Pengkhususan'], progdip_name], :order => 'unit ASC').map(&:unit).uniq.compact
#     if other_dept.include?(department) || progdip_name.include?(department)
#       staff_ids = Position.find(:all, :joins => :staff, :conditions => ['unit=?', department]).map(&:staff_id) 
#     else
#       staff_ids=[]
#       position_posbasic = Position.find(:all, :conditions => ['unit IN(?)', ['Diploma Lanjutan', 'Pos Basik', 'Pengkhususan']])
#       position_posbasic.each do |post_pbasic|
#         staff_ids << post_pbasic.staff_id if post_pbasic.tasks_main.include?(department)
#       end
#     end
#     if !department.blank? && staff_id.blank? && staff_name.blank? && staff_ids.count > 0
#       a="staff_id=?" if staff_ids.count > 0
#       0.upto(staff_ids.count-2) do |x|
#         a+=" OR staff_id=? "
#       end
#     end
#     ["("+a+")", staff_ids] if !department.blank? && staff_id.blank? && staff_name.blank?
#   end
  
  def staff_name_conditions
    if !staff_name.blank? && department.blank?
      staff_ids = Staff.find(:all, :conditions => ['name ILIKE (?)', "%#{staff_name}%"]).map(&:id)
      a="staff_id=?" if staff_ids.count > 0
      0.upto(staff_ids.count-2) do |x|
        a+=" OR staff_id=? "
      end
    end
    ["("+a+")", staff_ids] if !staff_name.blank? && department.blank? 
  end

  def staff_id_conditions
     ["staff_id=?", staff_id] if !staff_id.blank? && !department.blank?
  end
  
  def icno_conditions
    if !icno.blank? #&& department.blank?
      staff_ids = Staff.find(:all, :conditions => ['icno ILIKE (?)', "%#{icno}%"]).map(&:id)
      a="staff_id=?" if staff_ids.count > 0
      0.upto(staff_ids.count-2) do |x|
        a+=" OR staff_id=? "
      end
    end
    ["("+a+")", staff_ids] if !icno.blank? && staff_ids.count > 0 #&& department.blank? 
  end
  
  def schedulestart_start_conditions
    unless schedulestart_start.blank?
      ptschedule_ids = Ptschedule.find(:all, :conditions => ['start >=?', schedulestart_start]).map(&:id)
      ptdo_ids = Ptdo.find(:all, :conditions => ['ptschedule_id IN(?)', ptschedule_ids]).map(&:id)
      ptdo_ids2 = Ptdo.all.map(&:id)
      a="id=?" if ptdo_ids.count > 0
      0.upto(ptdo_ids.count-2) do |x|
        a+=" OR id=? "
      end
      b="id!=?" if ptdo_ids2.count > 0
      0.upto(ptdo_ids2.count-2) do |x|
        b+=" AND id!=? "
      end
    end
     if !schedulestart_end.blank? 
      if ptdo_ids.count > 0
        ["("+a+")", ptdo_ids] 
      else
	 ["("+b+")", ptdo_ids2] 
      end
    end
  end
  
  def schedulestart_end_conditions
    unless schedulestart_end.blank?
      ptschedule_ids = Ptschedule.find(:all, :conditions => ['start <=?', schedulestart_end]).map(&:id)
      ptdo_ids = Ptdo.find(:all, :conditions => ['ptschedule_id IN(?)', ptschedule_ids]).map(&:id)
      ptdo_ids2 = Ptdo.all.map(&:id)
      a="id=?" if ptdo_ids.count > 0
      0.upto(ptdo_ids.count-2) do |x|
        a+=" OR id=? "
      end
      b="id!=?" if ptdo_ids2.count > 0
      0.upto(ptdo_ids2.count-2) do |x|
        b+=" AND id!=? "
      end
    end
    if !schedulestart_end.blank? 
      if ptdo_ids.count > 0
        ["("+a+")", ptdo_ids] 
      else
	 ["("+b+")", ptdo_ids2] 
      end
    end
  end
  
  def orders
    "staff_id ASC"
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
