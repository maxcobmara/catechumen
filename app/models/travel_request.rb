class TravelRequest < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, controller searches, variables, lists, relationship checking
  before_save :set_to_nil_where_false
  
  belongs_to :applicant,    :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :replacement,  :class_name => 'Staff', :foreign_key => 'replaced_by'
  belongs_to :headofdept,   :class_name => 'Staff', :foreign_key => 'hod_id'
  
  validates_presence_of :staff_id, :request_code, :destination, :purpose, :depart_at, :return_at
  validates_presence_of :own_car_notes, :if => :mycar?
  validate :validate_end_date_before_start_date
  validates_presence_of :replaced_by, :if => :check_submit?
  validates_presence_of :hod_id,      :if => :check_submit?
  
  #before logic
  def set_to_nil_where_false
    if is_submitted == false
      self.submitted_on	= nil
    end
    
    if hod_accept == false
      self.hod_accept_on	= nil
    end
  end
  
  
  #validation logic
  def validate_end_date_before_start_date
    if return_at && depart_at
      errors.add(:depart_at, "Your must leave before you return") if return_at < depart_at || depart_at < DateTime.now
    end
  end
  
  def mycar?
    transport_type == 'own'
  end
  
  def check_submit?
    is_submitted == true
  end
  
  def requires_approval
    if hod_accept == nil && hod_id == User.current_user.staff_id
      (link_to image_tag("approval.png", :border => 0), :action => 'edit', :id => travel_request).to_s
    elsif is_submitted == true && hod_accept == nil && staff_id == User.current_user.staff_id
      ""
    elsif is_submitted == false || is_submitted == nil
      (link_to image_tag("edit.png", :border => 0), :action => 'edit', :id => travel_request).to_s
    else
    end
  end
  
  
  #controller searches
  def self.in_need_of_approval
      find(:all, :conditions => ['hod_id = ? AND is_submitted = ? AND hod_accept IS ?', User.current_user.staff_id, true, nil])
  end
  
  def self.my_travel_requests
      find(:all, :conditions => ['staff_id = ?', User.current_user.staff_id])
  end
  
  
  
  #lists
  def repl_staff
      siblings = User.current_user.staff.position.sibling_ids
      children = User.current_user.staff.position.child_ids
      possibles = siblings + children
      replacements = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", possibles]).map(&:staff_id)
      replacements
  end
  
  def hods
      if User.current_user.staff.position.root_id == User.current_user.staff.position.parent_id
        hod = User.current_user.staff.position.root_id
        approver = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", hod]).map(&:staff_id)
      else
        hod = User.current_user.staff.position.root.child_ids
        approver = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", hod]).map(&:staff_id)
      end
      approver
  end
end
