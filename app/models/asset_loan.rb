class AssetLoan < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_staff_when_blank, :set_loaned_by
  
  belongs_to :asset
  belongs_to :staff   #staff_id
  belongs_to :owner, :class_name => 'Staff', :foreign_key => 'loaned_by'
  belongs_to :loanofficer,   :class_name => 'Staff', :foreign_key => 'loan_officer'
  belongs_to :hodept,   :class_name => 'Staff', :foreign_key => 'hod'
  belongs_to :receivedpfficer, :class_name => 'Staff', :foreign_key => 'received_officer'
  
  def self.borrowings
    find(:all, :conditions => ['is_returned !=? OR is_approved IS NOT ?', true, nil])
  end
  
  
  def set_staff_when_blank
    if staff_id.blank?
      self.staff_id = User.current_user.staff_id
    end
  end
  
  def set_loaned_by
    if loaned_by.blank?
      self.loaned_by = asset.assignedto_id
    end
  end
  
  def loaner
     if staff_id.blank?
       User.current_user.staff.staff_name_with_position
     else
       staff.staff_name_with_position
     end
  end
  
  def unit_members
      #6-Maslinda(IT),7-16-Ketua2 Program/Subjek(bwh TPA),17-19-Ketua2 Unit(bwh TPHEP),Unit2 bwh Pembantu Tadbir
      hods = [6,7,8,9,10,11,12,13,14,15,16,17,18,19,25,26,27,28,29,30,31]     #positions of hod - Ketua-ketua Unit's position IDs
      loaned_by_position_id = Position.find_by_staff_id(self.loaned_by).id    #loaned_by --> staff_id 
      unit_members = []
      if hods.include?(loaned_by_position_id)                                 #if hods.include?(self.loaned_by)-if logged user 1 of hod 
        #subordinates = Position.find(:first,:conditions=>['staff_id=?',self.loaned_by]).descendants
        #unit_members << self.loaned_by  #loaned_by_position_id
        subordinates = Position.find(:first,:conditions=>['staff_id=?',self.loaned_by]).subtree #(self+descendants) - replace line 44 & 45 with this
			else
			  superior = Position.find(:first,:conditions=>['staff_id=?',self.loaned_by]).parent.staff_id
			  subordinates = Position.find(:first,:conditions=>['staff_id=?',self.loaned_by]).siblings  #(siblings only)
			  unit_members << superior if superior != nil
			end
			subordinates.each do |x|
			  unit_members << x.staff_id if x.staff_id !=nil
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
  named_scope :myloan,        :conditions =>  ["staff_id=?", User.current_user.staff_id]
  named_scope :internal,      :conditions =>  ["loantype =? ", 1]
  named_scope :external,      :conditions =>  ["loantype =? ", 2]
  named_scope :onloan,        :conditions =>  ["is_approved IS TRUE AND is_returned IS NOT TRUE"]
  named_scope :pending,       :conditions =>  ["is_approved IS NULL AND loan_officer IS NULL"]
  named_scope :rejected,      :conditions =>  ["is_approved IS FALSE"]
  named_scope :overdue,       :conditions =>  ["is_approved IS TRUE AND is_returned IS NULL AND expected_on>=?",Date.today]
  FILTERS = [
    {:scope => "all",       :label => "All"},
    {:scope => "myloan",    :label => "My Loan"},
    {:scope => "internal",  :label => "Internal"},
    {:scope => "external",  :label => "External"},
    {:scope => "onloan",    :label => "On Loan"},
    {:scope => "pending",   :label => "Pending"},
    {:scope => "rejected",  :label => "Rejected"},
    {:scope => "overdue",   :label => "Due/Overdue"}
  ]
  
end
