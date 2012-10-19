class StaffAttendance < ActiveRecord::Base
  
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  belongs_to :attended, :class_name => 'Staff', :foreign_key => 'thumb_id', :primary_key => 'thumb_id'
  belongs_to :approver, :class_name => 'Staff', :foreign_key => 'approved_by'
  
  validates_presence_of :reason
  
  def self.is_controlled
    find(:all, :conditions => ['log_type =?', "I"], :order => 'logged_at DESC', :limit => 1000)
  end
  
  def self.find_mylate
    find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id=? AND logged_at::time > ?", true, "I", User.current_user.staff.thumb_id, "08:30" ], :order => 'logged_at DESC')
  end
  
  def self.find_approvelate
    find(:all, :conditions => ["trigger=? AND thumb_id IN (?)", true, peeps], :order => 'logged_at DESC')
  end
  
  #Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", User.current_user.staff.position.child_ids]).map(&:staff_id)
  
  #User.current_user.staff.position.child_ids
  #Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", possibles]).map(&:staff_id)
  
  def self.peeps
    mystaff = User.current_user.staff.position.child_ids
    mystaffids = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", mystaff]).map(&:staff_id)
    thumbs = Staff.find(:all, :select => :thumb_id, :conditions => ["id IN (?)", mystaffids]).map(&:thumb_id)
  end
  
  def attendee_details 
      if attended.blank?
        thumb_id.to_s + " - " +"Thumb ID not reged"
      elsif thumb_id?
        attended.name
      else 
      end
  end
  
  def group_by_thingy
    logged_at.to_date.to_s
  end
  
  def r_u_late
    mins = logged_at.min.to_s
    if mins.size == 1
      mins = "0" + mins
    end
    timmy = ((logged_at.hour - 8).to_s + mins).to_i
    if timmy > 830 && self.trigger != false
      "flag"
    else 
    end
  end
  
  def timmy2
    mins = logged_at.min.to_s
    if mins.size == 1
      mins = "0" + mins
    end
    timmy = ((logged_at.hour - 8).to_s + mins).to_i
  end
  
  
end
