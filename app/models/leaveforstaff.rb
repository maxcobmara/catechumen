class Leaveforstaff < ActiveRecord::Base

  before_save :save_my_approvers
  
  belongs_to :applicant,    :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :replacement,  :class_name => 'Staff', :foreign_key => 'replacement_id'
  belongs_to :seconder,     :class_name => 'Staff', :foreign_key => 'approval1_id'
  belongs_to :approver,     :class_name => 'Staff', :foreign_key => 'approval2_id'
  
  validates_presence_of :staff_id, :leavetype
  validate :validate_end_date_before_start_date, :validate_leave_application_is_unique
  
  def validate_end_date_before_start_date
    if leavenddate && leavestartdate && leavetype!=2
      errors.add(:base, I18n.t('staffleave.begin_before_ends')) if leavenddate < leavestartdate || leavestartdate < DateTime.now
    end
  end
  
  def validate_leave_application_is_unique
    #existing leave
    leavedays = Leaveforstaff.find(:all, :conditions=>['staff_id=?',applicant])
    e_leavedates = []
    leavedays.each do |leave|
      currdate = leave.leavestartdate
      daycount= leave.leavenddate+1-leave.leavestartdate
      0.upto(daycount-1) do |t|
        if currdate <= leave.leavenddate 
          e_leavedates << currdate
          currdate+=1.days
        end
      end
    end
    #current application 
    c_leavedates = []
    c_currdate = leavestartdate
    c_daycount=leavenddate+1-leavestartdate
    0.upto(c_daycount-1) do |u|
      if c_currdate  <= leavenddate
        c_leavedates << c_currdate
        c_currdate+=1.days
      end
    end
    duplicates = (e_leavedates & c_leavedates).count
    if duplicates > 0 
      errors.add(:base, I18n.t('staffleave.leave_already_taken'))
      return false
    else
      return true
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
    #if applicant.position.parent.staff.id == []
      #approver1 = nil
    #else
      #approver1 = applicant.position.parent.staff.id
    #end
    #---------------------------
    #temp: remove 'Ketua Teras' from Task & Responsibilities if not required+Ketua Teras part(below)
    
    applicant_unit = applicant.position.unit
    applicant_grade = applicant.staffgrade.name[-2,2]
    unit_members=Position.find(:all, :joins => :staff, :conditions =>['unit=? and positions.name!=?', applicant_unit, "ICMS Vendor Admin"], :order => "ancestry_depth ASC")
    
    if Programme.roots.map(&:name).include?(applicant_unit)
      #Academician--start---
      highest_rank = unit_members.sort_by{|x|x.staffgrade.name[-2,2]}.last
      highest_grade = highest_rank.staffgrade.name[-2,2]
      maintasks = applicant.position.tasks_main  
      if maintasks.include?("Ketua Program") 
        approver1 =  Position.find(:first, :conditions => ['name=?', "Timbalan Pengarah Akademik (Pengajar)"]).staff_id
      elsif maintasks.include?("Ketua Teras")
	if highest_grade > applicant_grade #kp exist
	  approver1 = highest_rank.staff_id 
	else #kp not exist - die ketua prog (tanggung tugas)
	  approver1 =  Position.find(:first, :conditions => ['name=?', "Timbalan Pengarah Akademik (Pengajar)"]).staff_id
	end
      else #pengajar
        app=0
	kt_id=[]
	unit_members.each do |u|
          if u.tasks_main.include?("Ketua Teras")
	    app+=1
	    kt_id<< u.id
	  elsif u.tasks_main.include?("Ketua Program")
	    app+=1
	  end
	end
	if app==1
	  approver1 = highest_rank.staff_id
	elsif app==2
	  approver1 = Position.find(kt_id[0]).staff_id
	end
      end
      #Academician--end---
      
    elsif ["Teknologi Maklumat", "Perpustakaan", "Kewangan & Akaun", "Sumber Manusia"].include?(applicant_unit) || applicant_unit.include?("logistik") || applicant_unit.include?("perkhidmatan")
      #Administration--start--
      highest_rank = unit_members.sort_by{|x|x.staffgrade.name[-2,2]}.last
      highest_grade = highest_rank.staffgrade.name[-2,2]
      if highest_grade > applicant_grade #staffs
        approver1 = highest_rank.staff_id
      elsif highest_grade == applicant_grade #Ketua Unit
        approver1 =  applicant.position.parent.staff_id
      end
      #Administration--end---
    
    elsif ["Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor"].include?(applicant_unit)
      approver1 = Position.find(:first, :conditions => ['unit=?', "Pentadbiran"]).staff_id

    elsif applicant_unit == "Pengurusan Tertinggi"
      if applicant.position.name=="Pengarah"
        approver1=nil
      else
        approver1=Position.find(:first, :conditions => ['name=?', "Pengarah"]).staff_id
      end
      
    else
      #Administration2--start---
      if applicant.position.parent.staff.id == []
        approver1 = nil
      else
        approver1 = applicant.position.parent.staff.id   #if pentadbiran OK - applicant.position.unit=="Pentadbiran"
      end
      #Administration2--end---
      #-----------------------------------
    end
 
  end
  
  def set_approver2
    #if applicant.position.parent.is_root?
      #approver2 = 0
    #else
      #approver2 = applicant.position.parent.parent.staff.id
    #end
    #----------
    applicant_unit = applicant.position.unit
    applicant_grade = applicant.staffgrade.name[-2,2]
    unit_members=Position.find(:all, :joins => :staff, :conditions =>['unit=? and positions.name!=?', applicant_unit, "ICMS Vendor Admin"], :order => "ancestry_depth ASC")
    if Programme.roots.map(&:name).include?(applicant_unit)
      #Academician--start---
      highest_rank = unit_members.sort_by{|x|x.staffgrade.name[-2,2]}.last
      highest_grade = highest_rank.staffgrade.name[-2,2]
      maintasks = applicant.position.tasks_main  
      if maintasks.include?("Ketua Program") 
        approver2 =  Position.find(:first, :conditions => ['name=?', "Pengarah"]).staff_id
      elsif maintasks.include?("Ketua Teras")
	if highest_grade > applicant_grade #kp exist
	  approver2 = Position.find(:first, :conditions => ['name=?', "Timbalan Pengarah Akademik (Pengajar)"]).staff_id
	else #kp not exist - die ketua prog (tanggung tugas)
	  approver2 =  Position.find(:first, :conditions => ['name=?', "Pengarah"]).staff_id
	end
      else #pengajar je
	app=0
	kt_id=[]
	unit_members.each do |u|
          if u.tasks_main.include?("Ketua Teras")
	    app+=1
	    kt_id << u.id
	  elsif u.tasks_main.include?("Ketua Program")
	    app+=1
	    kt_id << u.id
	  end
	end
	if app==1
	  approver2 = Position.find(:first, :conditions => ['name=?', "Timbalan Pengarah Akademik (Pengajar)"]).staff_id
	elsif app==2
	  approver1 = Position.find(kt_id[0]).staff_id
	end
      end
      #Academician--end---
      
    elsif ["Teknologi Maklumat", "Perpustakaan", "Kewangan & Akaun", "Sumber Manusia"].include?(applicant_unit) || applicant_unit.include?("logistik") || applicant_unit.include?("perkhidmatan") 
      #Administration--start---
      sapprover1 = Position.find_by_staff_id(approval1_id)  #retrieve position
      highest_rank = unit_members.sort_by{|x|x.staffgrade.name[-2,2]}.last
      highest_grade = highest_rank.staffgrade.name[-2,2]
      if highest_grade > applicant_grade  #staffs
        approver2 = sapprover1.parent.staff_id
      elsif highest_grade == applicant_grade  #ketua unit
        approver2 = Position.find(:first, :conditions => ['name=?', "Pengarah"]).staff_id
      end
      #Administration--end---
    
    elsif ["Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor"].include?(applicant_unit)
      sapprover1 = Position.find_by_staff_id(approval1_id)  #retrieve position
      approver2 = sapprover1.parent.staff_id
    elsif applicant_unit == "Pengurusan Tertinggi"
      approver2=0
    else
      #Administration2--start---
      if applicant.position.parent.is_root?
        approver2 = 0
      elsif applicant.position.unit=="Pentadbiran"
	approver2 = Position.find(:first, :conditions => ['name=?', "Pengarah"]).staff_id
      else
        approver2 = applicant.position.parent.parent.staff.id
      end
      #Administration2--end--
    end
    #---------------------
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
  
  def balance_before
    bal_bef = 0
    leavedays = Leaveforstaff.find(:all, :conditions=>['staff_id=? AND leavetype=? and leavestartdate <?',applicant, 1, leavestartdate])
    leavedays.each do |leave|
      bal_bef+=leave.leavenddate+1-leave.leavestartdate
    end
    cuti_rehat_entitlement - bal_bef if cuti_rehat_entitlement!=nil
  end
  
  def balance_after
    bal_aft = 0
    leavedays = Leaveforstaff.find(:all, :conditions=>['staff_id=? AND leavetype=? and leavestartdate <=?',applicant, 1, leavestartdate])
    leavedays.each do |leave|
      bal_aft+=leave.leavenddate+1-leave.leavestartdate
    end
    cuti_rehat_entitlement - bal_aft if cuti_rehat_entitlement!=nil
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
