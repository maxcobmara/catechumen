class Leaveforstaff < ActiveRecord::Base

  before_save :save_my_approvers
  
  belongs_to :applicant,    :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :replacement,  :class_name => 'Staff', :foreign_key => 'replacement_id'
  belongs_to :seconder,     :class_name => 'Staff', :foreign_key => 'approval1_id'
  belongs_to :approver,     :class_name => 'Staff', :foreign_key => 'approval2_id'
  
  validates_presence_of :staff_id, :leavetype
  validate :validate_end_date_before_start_date
  
  def validate_end_date_before_start_date
    if leavenddate && leavestartdate && leavetype!=2
      errors.add(:leavenddate, "Your leave must begin before it ends") if leavenddate < leavestartdate || leavestartdate < DateTime.now
    end
  end
  
  def moo
    Login.current_login.staff_id unless Login.current_login.staff_id.blank?
  end
  
  named_scope :relevant,    :conditions =>  ["staff_id=? OR approval1_id=? OR approval2_id=?", Login.current_login.staff_id, Login.current_login.staff_id, Login.current_login.staff_id]
  named_scope :mine,        :conditions =>  ["staff_id=?", Login.current_login[:staff_id]]
  named_scope :forsupport,  :conditions =>  ["approval1_id=? AND approval1 IS ?", Login.current_login.staff_id, nil]
  named_scope :forapprove,  :conditions =>  ["approval2_id=? AND approver2 IS ? AND approval1=?", Login.current_login.staff_id, nil, true]

  FILTERS = [
    {:scope => "relevant",        :label => I18n.t('staffleave.all')},
    {:scope => "mine",       :label => I18n.t('staffleave.myleave')},
    {:scope => "forsupport", :label => I18n.t('staffleave.formysupport')},
    {:scope => "forapprove", :label => I18n.t('staffleave.formyapproval')}
    ]

  def self.find_main
    Staff.find(:all, :condition => ["staff_id=? OR approval1_id=? OR approval2_id=?", Login.current_login.staff_id, Login.current_login.staff_id, Login.current_login.staff_id])
  end
  
  def save_my_approvers
    if applicant.position.nil?
    else
      if approval1_id == nil
        self.approval1_id = set_approver1
      end
      if approval2_id == nil
        self.approval2_id = set_approver2
      end
    end
  end
  
  def set_approver1
    if applicant.position.parent.staff.id == []
      approver1 = nil
    else
      approver1 = applicant.position.parent.staff.id
    end    
  end
  
  def set_approver2
    if applicant.position.parent.is_root?
      approver2 = 0
    else
      approver2 = applicant.position.parent.parent.staff.id
    end
  end
  
  
  
  def leave_for
    if leavenddate == 'null' || leavestartdate == 'null' || (leavenddate - leavestartdate) == 0
      1
    else
      ((leavenddate - leavestartdate).to_i) + 1
    end
  end
  
  def show_to_day
    if (leavenddate - leavestartdate) == 0
      ""
    else
      " -- " + I18n.l(leavenddate).to_s #(leavenddate.strftime("%d %b %Y")).to_s
    end
  end
  

  def cuti_rehat_entitlement
    getdata = applicant.staffgrade.name
      if getdata == nil
        a = 0
      else
       a = (applicant.staffgrade.name)[-2,4].to_i
      end
    b = Date.today.year - applicant.appointdt.try(:year)
    if    a < 21 && b < 10
      20
    elsif a < 21 && b > 10
      25
    elsif a < 31 && b < 10
      25
    elsif a < 31 && b > 10
      30
    elsif a > 30 && b < 10
      30
    else
      35
    end
  end
  
  def leave_balance
    accumulated_leave = 0
    leavedays = Leaveforstaff.find(:all, :conditions=>['staff_id=? AND leavetype=?',applicant, 1])
    leavedays.each do |leave|
      accumulated_leave+=leave.leavenddate+1-leave.leavestartdate
    end
    cuti_rehat_entitlement - accumulated_leave if cuti_rehat_entitlement!=nil
  end
  
  def applicant_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "Staff No Longer Exists" 
       else
         applicant.mykad_with_staff_name
       end
  end
  
  def endorser
    if approval2_id == 0
      "Note Required"
    else
      approver.name
    end
  end
  
  def repl_staff
    sibpos = applicant.position.sibling_ids
    dept = applicant.position.unit
    sibs   = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?) and unit=?", sibpos, dept]).map(&:staff_id)
    applicant = Array(staff_id)
    sibs - applicant
  end
  
STAFFLEAVETYPE = [
         #  Displayed       stored in db
         [ "Cuti Rehat",1 ],
         [ "Cuti Sakit",2],
         [ "Cuti Tanpa Rekod",3 ],
         [ "Cuti Separuh Gaji",4 ],
         [ "Cuti Tanpa Gaji",5 ],
         [ "Cuti Bersalin",6 ],
         [ "Cuti Haji",7 ]
 ]
end
