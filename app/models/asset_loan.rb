class AssetLoan < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_staff_when_blank, :set_loaned_by
  
  belongs_to :asset
  belongs_to :staff   #staff_id
  belongs_to :owner, :class_name => 'Staff', :foreign_key => 'loaned_by'
  belongs_to :loanofficer,   :class_name => 'Staff', :foreign_key => 'loan_officer'
  belongs_to :hodept,   :class_name => 'Staff', :foreign_key => 'hod'
  belongs_to :receivedofficer, :class_name => 'Staff', :foreign_key => 'received_officer'
  
  validates_presence_of :loantype
  validates_presence_of :reasons, :if => :must_assign_if_external?   #16July2013
  validates_presence_of :hod, :if => :is_approved?
  validates_presence_of :returned_on, :received_officer, :if => :is_returned?
  
  def must_assign_if_external?  #16July2013
    loantype==2 
  end
  
  def self.borrowings
    find(:all, :conditions => ['is_returned !=? OR is_approved IS NOT ?', true, nil])
  end
  
  
  def set_staff_when_blank
    if staff_id.blank?
      self.staff_id = Login.current_login.staff_id
    end
  end
  
  def set_loaned_by
    if loaned_by.blank?
      self.loaned_by = asset.assignedto_id
    end
  end
  
  def loaner
     if staff_id.blank?
       Login.current_login.staff.staff_name_with_position
     else
       staff.staff_name_with_position
     end
  end
  
  def unit_members
    exist_unit_of_staff_in_position = Position.find(:all, :conditions =>['unit is not null and staff_id is not null']).map(&:staff_id).uniq
    if exist_unit_of_staff_in_position.include?(self.loaned_by)
      current_unit = Position.find_by_staff_id(self.loaned_by).unit    ##Position.where(staff_id: self.loaned_by).unit
      unit_members = Position.find(:all, :conditions=>['unit=?', current_unit]).map(&:staff_id).uniq-[nil]   
      #unit_members = Position.where(unit: unit_hod).pluck(:staff_id)
    else
      unit_members = []#Position.find(:all, :conditions=>['unit=?', 'Teknologi Maklumat']).map(&:staff_id).uniq-[nil]  
    end
    unit_members    #collection of staff_id (member of a unit/dept)
  end
  
  def status
    if is_approved == true
      "tick.png"
    elsif is_approved == false
      "cross.png"
    else
      "new.png"
    end
  end
  
  #---------
  named_scope :all 
  named_scope :myloan,        :conditions =>  ["staff_id=?", Login.current_login.staff_id]
  named_scope :internal,      :conditions =>  ["loantype =? ", 1]
  named_scope :external,      :conditions =>  ["loantype =? ", 2]
  named_scope :onloan,        :conditions =>  ["is_approved IS TRUE AND is_returned IS NOT TRUE"]
  named_scope :pending,       :conditions =>  ["is_approved IS NULL AND loan_officer IS NULL"]
  named_scope :rejected,      :conditions =>  ["is_approved IS FALSE"]
  named_scope :overdue,       :conditions =>  ["is_approved IS TRUE AND is_returned IS NULL AND expected_on<=?",Date.today]
  FILTERS = [
    {:scope => "all",       :label => I18n.t('assetloan.all')},
    {:scope => "myloan",    :label => I18n.t('assetloan.my_loan')},
    {:scope => "internal",  :label => I18n.t('assetloan.internal')},
    {:scope => "external",  :label => I18n.t('assetloan.external')},
    {:scope => "onloan",    :label => I18n.t('assetloan.on_loan')},
    {:scope => "pending",   :label => I18n.t('assetloan.pending')},
    {:scope => "rejected",  :label => I18n.t('assetloan.rejected')},
    {:scope => "overdue",   :label => I18n.t('assetloan.due_overdue')}
  ]

end
