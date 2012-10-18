class StaffAttendance < ActiveRecord::Base
  
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  belongs_to :attended, :class_name => 'Staff', :foreign_key => 'thumb_id', :primary_key => 'thumb_id'
  belongs_to :approver, :class_name => 'Staff', :foreign_key => 'approved_by'
  
  def self.is_controlled
    find(:all, :conditions => ['log_type =?', "I"], :order => 'logged_at DESC', :limit => 1000)
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
    if timmy > 830
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
