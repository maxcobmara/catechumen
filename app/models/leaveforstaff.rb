class Leaveforstaff < ActiveRecord::Base
  #has_many :staffs
  
  #belongs_to :staff
  belongs_to :applicant,  :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :replacement, :class_name => 'Staff', :foreign_key => 'replacement_id'
  
  
  #---------Validation-----------------#
  validates_presence_of :staff_id, :leavetype
  #----------------------------------------#
  
  def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def leave_for
    if leavenddate == 'null' || leavestartdate == 'null' || (leavenddate - leavestartdate) == 0
      1
    else
      (leavenddate - leavestartdate).to_i
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
