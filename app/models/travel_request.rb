class TravelRequest < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_to_nil_where_false, :set_total, :set_mileage_nil_when_not_own_car
  
  belongs_to :applicant,    :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :replacement,  :class_name => 'Staff', :foreign_key => 'replaced_by'
  belongs_to :headofdept,   :class_name => 'Staff', :foreign_key => 'hod_id'
  
  belongs_to :travel_claim
  belongs_to :document
  
  validates_presence_of :staff_id, :destination, :depart_at, :return_at
  validates_presence_of :own_car_notes, :if => :mycar?
  validate :validate_end_date_before_start_date
  validates_presence_of :replaced_by, :if => :check_submit?
  validates_presence_of :hod_id,      :if => :check_submit?
  
  
  has_many :travel_claim_logs, :dependent => :destroy
  accepts_nested_attributes_for :travel_claim_logs, :reject_if => lambda { |a| a[:destination].blank? }, :allow_destroy =>true
  
  
  #before logic
  def set_to_nil_where_false
    if is_submitted == true
      self.submitted_on	= Date.today
    end
    
    if hod_accept == false
      self.hod_accept_on	= nil
    end
    
    if !mycar?#own_car == false 
      self.own_car_notes =''
      self.mileage = nil
    end
  end
  
  def set_mileage_nil_when_not_own_car
    #true for mileage allowance
    #false for mileage replacement
    unless own_car
      self.mileage_replace = nil
    end
  end
  
  def set_total
    self.log_mileage = total_mileage_request
    self.log_fare = total_km_money_request
  end
  
  
  #validation logic
  def validate_end_date_before_start_date
    if return_at && depart_at
      errors.add(:depart_at, "Your must leave before you return") if return_at < depart_at
    end
  end
  
  def mycar?
    own_car == true
  end
  
  def check_submit?
    is_submitted == true
  end
  
  def requires_approval
    if hod_accept == nil && hod_id == Login.current_login.staff_id
      (link_to image_tag("approval.png", :border => 0), :action => 'edit', :id => travel_request).to_s
    elsif is_submitted == true && hod_accept == nil && staff_id == Login.current_login.staff_id
      ""
    elsif is_submitted == false || is_submitted == nil
      (link_to image_tag("edit.png", :border => 0), :action => 'edit', :id => travel_request).to_s
    else
    end
  end
  
  
  #controller searches
  def self.in_need_of_approval
    find(:all, :conditions => ['hod_id = ? AND is_submitted = ? AND (hod_accept IS ? OR hod_accept = ?)', Login.current_login.staff_id, true, nil, false])
  end
  
  def self.my_travel_requests
      find(:all, :conditions => ['staff_id = ?', Login.current_login.staff_id])
  end
  
  
  
  #lists
  def document_refno
    document.refno if document
  end
  
  def document_refno=(refno)
    self.document = Document.find_by_refno(refno) unless refno.blank?
  end
  
  #ref:gmail-sept15,2012-Checking for broken association - refer document.rb (line 17), index-line 69, show_main-line 13
  def reference_document
    if document.blank?
      "None Assigned"
    else
      document.refno+" : "+document.title+" : dated "+document.letterdt.strftime("%d-%b-%Y").to_s
    end
  end
  
  def repl_staff
      siblings = Login.current_login.staff.position.sibling_ids
      children = Login.current_login.staff.position.child_ids
      possibles = siblings + children
      replacements = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", possibles]).map(&:staff_id)
      replacements
  end
  
  def hods
      if Login.current_login.staff.position.root_id == Login.current_login.staff.position.parent_id
        hod = Login.current_login.staff.position.root_id
        approver = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", hod]).map(&:staff_id)
      else
        hod = Login.current_login.staff.position.root.child_ids
        hod << Login.current_login.staff.position.root_id
        approver = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", hod]).map(&:staff_id)
      end
      approver
  end
  
  def total_mileage_request
    #other_claims_total + public_transport_totals
    travel_claim_logs.sum(:mileage)
  end
  
  def total_km_money_request
    #other_claims_total + public_transport_totals
    travel_claim_logs.sum(:km_money)
  end
end
