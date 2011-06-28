class Leaveforstaff < ActiveRecord::Base

  before_save :save_my_approvers
  
  belongs_to :applicant,    :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :replacement,  :class_name => 'Staff', :foreign_key => 'replacement_id'
  belongs_to :seconder,     :class_name => 'Staff', :foreign_key => 'approval1_id'
  belongs_to :approver,     :class_name => 'Staff', :foreign_key => 'approval2_id'
  
  validates_presence_of :staff_id, :leavetype
  
  named_scope :mine,        :conditions =>  ["staff_id=?", User.current_user.staff_id]
  named_scope :forsupport,  :conditions =>  ["approval1_id=? AND approval1 IS ?", User.current_user.staff_id, nil]
  named_scope :forapprove,  :conditions =>  ["approval2_id=? AND approver2 IS ? AND approval1=?", User.current_user.staff_id, nil, true]


  FILTERS = [
    {:scope => "all",        :label => "All"},
    {:scope => "mine",       :label => "My Leave"},
    {:scope => "forsupport", :label => "For My Support"},
    {:scope => "forapprove", :label => "For My Approval"}
    ]

  
  def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def save_my_approvers
   self.approval1_id = applicant.position.bosses.staff.id
   self.approval2_id = applicant.position.bosses.bosses.staff.id
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
      " -- " + (leavenddate.strftime("%d %b %Y")).to_s
    end
  end
  

  def cuti_rehat_entitlement
    a = (applicant.staffgrade.name)[-2,4].to_i
    b = Date.today.year - applicant.appointdt.year
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
