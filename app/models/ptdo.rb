class Ptdo < ActiveRecord::Base
  before_save  :whoami, :auto_unit_approval_for_academician
  
  belongs_to  :ptschedule
  belongs_to  :staff
  belongs_to  :applicant, :class_name => 'Staff',   :foreign_key => 'staff_id'
  belongs_to  :replacement, :class_name => 'Staff', :foreign_key => 'replacement_id'
  has_many    :staff_appraisals, :through => :staff
  
  def whoami
    #self.staff_id = Login.current_login.staff.id
    self.ptcourse_id = ptschedule.ptcourse.id
  end
  
  def auto_unit_approval_for_academician
    if unit_approve.blank? 
      if applicant.logins.first.roles.map(&:name).include?("Lecturer") || Programme.roots.map(&:name).include?(applicant.position.unit)
        self.unit_approve=true
        self.unit_review="Auto-approved"
        self.justification="Not applicable for academician"
      end
    end
  end
  
  def self.search(selected_status, search)
    if search!=""
      searched_ptcourses_ids=Ptcourse.find(:all, :conditions =>['name ILIKE (?)', "%#{search}%"]).map(&:id)
      searched_staff_ids=Staff.find(:all, :conditions =>['name ILIKE (?)', "%#{search}%"]).map(&:id)
      ptdos=Ptdo.find(:all, :conditions => ['ptcourse_id IN(?) or staff_id IN(?)', searched_ptcourses_ids, searched_staff_ids], :order=>'ptschedule_id DESC')
      ptdos_ids=ptdos.map(&:id)
    end
    if ptdos_ids 
      if selected_status!="all2"
        ptdos1_ids=Ptdo.rejected.map(&:id) if selected_status=="rejected"
        ptdos1_ids=Ptdo.a_unit_approval.map(&:id) if selected_status=="a_unit_approval"
        ptdos1_ids=Ptdo.a_dept_approval.map(&:id) if selected_status=="a_dept_approval"
        ptdos1_ids=Ptdo.approval_completed.map(&:id) if selected_status=="approval_completed"
        ptdos1_ids=Ptdo.report_submitted.map(&:id) if selected_status=="report_submitted"
        ptdos1_ids=Ptdo.a_pengarah_approval.map(&:id) if selected_status=="a_pengarah_approval"
        @ptdos=Ptdo.find(:all, :conditions => ['id IN(?) and id IN(?)', ptdos_ids, ptdos1_ids], :order=>'ptschedule_id DESC')
      else
        @ptdos=ptdos
      end
    else
      if selected_status!="all2"
        ptdos1_ids=Ptdo.rejected.map(&:id) if selected_status=="rejected"
        ptdos1_ids=Ptdo.a_unit_approval.map(&:id) if selected_status=="a_unit_approval"
        ptdos1_ids=Ptdo.a_dept_approval.map(&:id) if selected_status=="a_dept_approval"
        ptdos1_ids=Ptdo.approval_completed.map(&:id) if selected_status=="approval_completed"
        ptdos1_ids=Ptdo.report_submitted.map(&:id) if selected_status=="report_submitted"
        ptdos1_ids=Ptdo.a_pengarah_approval.map(&:id) if selected_status=="a_pengarah_approval"
        @ptdos=Ptdo.find(:all, :conditions => ['id IN(?)', ptdos1_ids], :order=>'ptschedule_id DESC')
      else
        @ptdos=Ptdo.find(:all, :order=>'ptschedule_id DESC')
      end
    end
  end
  
  def apply_dept_status
    if (unit_approve == false || dept_approve == false || final_approve == false)
      I18n.t("ptdos.application_rejected")#"Application Rejected"
    elsif unit_approve.nil? == true
      I18n.t("ptdos.awaiting_unit_approval")#"Awaiting Unit Approval"
    elsif unit_approve == true && dept_approve.nil? == true
      if applicant.logins.first.roles.map(&:name).include?("Lecturer") || Programme.roots.map(&:name).include?(applicant.position.unit)
        I18n.t("ptdos.awaiting_dept_approval")#unit approval - not applicable for academician
      else
        I18n.t("ptdos.approved_unit_head_await_dept_approval")#"Approved by Unit head, awaiting Dept approval"
      end
    elsif unit_approve == true && dept_approve == true && final_approve.nil? == true
      I18n.t("ptdos.approved_dept_head_await_pengarah_approval")#"Approved by Dept head, awaiting Pengarah approval"
    elsif dept_approve == true && dept_approve == true && final_approve == true && trainee_report.nil? == true
      I18n.t("ptdos.all_approvals_complete")#"All approvals complete"
    elsif dept_approve == true && dept_approve == true && final_approve == true && trainee_report.nil? == false
      I18n.t("ptdos.report_submitted")#"Report Submitted"
    else
      I18n.t("ptdos.status_not_available")#"Status Not Available"
    end
  end
  
  named_scope :rejected,                           :conditions => ["unit_approve is false or dept_approve is false or final_approve is false"]
  named_scope :a_unit_approval,               :conditions => ["unit_approve is null"]
  named_scope :a_dept_approval,              :conditions => ["unit_approve is true and dept_approve is null"]
  named_scope :approval_completed,        :conditions => ["dept_approve is true and dept_approve is true and final_approve is true and trainee_report is null"]
  named_scope :report_submitted,            :conditions =>  ["dept_approve is true and dept_approve is true and final_approve is true and trainee_report is not null"]
  named_scope :a_pengarah_approval,      :conditions => ["unit_approve is true and dept_approve is true and final_approve is null"]
  
  def self.filters(all2a)
    filtering=[[ I18n.t('ptschedule.all_records'), "all2"]]
    filtering << [ I18n.t("ptdos.awaiting_unit_approval"), "a_unit_approval"]
    filtering << [ I18n.t("ptdos.awaiting_dept_approval"), "a_dept_approval"]
    filtering << [ I18n.t("ptdos.approved_dept_head_await_pengarah_approval"), "a_pengarah_approval"]
    filtering << [ I18n.t("ptdos.all_approvals_complete"), "approval_completed"]
    filtering << [ I18n.t("ptdos.report_submitted"), "report_submitted"] 
    filtering << [ I18n.t("ptdos.application_rejected"), "rejected"]
    
    filtering
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
         staff.mykad_with_staff_name
       end
  end
  
  def self.staff_course_days(attended)
      if attended.duration_type == 0
        total_days = (attended.duration / 6).to_f
      elsif attended.duration_type == 1
        total_days = attended.duration*1
      elsif attended.duration_type == 2
        total_days = attended.duration*30
      elsif attended.duration_type == 3
        total_days = attended.duration*365
      end
      total_days  #hours in decimal
  end
  
  #used in Ptdosearches : Show & Ptdo : show_total_days, Ptdo.rb : model
  def self.staff_total_days(ptdoids_staff)
    sum_total_days = 0
    ptcourse_ids = Ptdo.find(:all, :conditions => ['id IN(?) AND final_approve=? AND trainee_report is not null', ptdoids_staff, true]).map(&:ptcourse_id)  #valid attended courses
    ptcourse_ids.each do |ptcourse_id|
      attended = Ptcourse.find(ptcourse_id)
      total_days=self.staff_course_days(attended)
      sum_total_days+=total_days
    end
    days_count = sum_total_days * 6 / 6
    bal_hours = sum_total_days * 6 % 6
    if bal_hours > 0
      if days_count.to_i > 0
        total_days_instring=days_count.to_i.to_s+" "+I18n.t('time.days')+" "+bal_hours.to_i.to_s+" "+I18n.t('time.hours')
      else
        total_days_instring=bal_hours.to_i.to_s+" "+I18n.t('time.hours')
      end
    else
      total_days_instring=days_count.to_i.to_s+" "+I18n.t('time.days') if days_count.to_i > 0
      total_days_instring=I18n.t('ptdos.nil') if days_count.to_i ==0
    end
    total_days_instring
  end
  
  #used in Ptdosearches : Show
  def self.staff_unit(curr_staff)
    unit_staff=curr_staff.try(:position).try(:unit)
    unit_staff=unit_staff.lstrip unless unit_staff.blank?
    if unit_staff =='Pos Basik' || unit_staff == 'Pengkhususan' || unit_staff== 'Diploma Lanjutan'
      @a_unit_staff=""
      pos_basic_name = Programme.find(:all, :conditions => ['ancestry_depth=? AND (course_type=? OR course_type=? OR course_type=?)', 0, 'Diploma Lanjutan', 'Pos Basik', 'Pengkhususan']).map(&:name) 
      staff_tasks_main=curr_staff.try(:position).try(:tasks_main)
      unless staff_tasks_main.blank?
        pos_basic_name.each do |pb_name| 
          @a_unit_staff=pb_name if staff_tasks_main.include?(pb_name)
        end
      end
      dept=@a_unit_staff
    else
      dept=unit_staff if unit_staff!='' 
    end
    dept
  end
  
  def unit_members
    #Academicians & Mgmt staff : "Teknologi Maklumat", "Perpustakaan", "Kewangan & Akaun", "Sumber Manusia","logistik", "perkhidmatan" ETC.. - by default staff with the same unit in Position will become unit members, whereby Ketua Unit='unit_leader' role & Ketua Program='programme_manager' role.
    #Exceptional for - "Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor" (subunit of Pentadbiran), Ketua Unit='unit_leader' with unit in Position="Pentadbiran" Note: whoever within these unit if wrongly assigned as 'unit_leader' will also hv access for all ptdos on these unit staff
 
    exist_unit_of_staff_in_position = Position.find(:all, :conditions =>['unit is not null and staff_id is not null']).map(&:staff_id).uniq
    if exist_unit_of_staff_in_position.include?(Login.current_login.staff_id)
      current_unit =Login.current_login.staff.position.unit #Position.find_by_staff_id(Login.current_login.staff_id).unit
      
      #replace current_unit value if academician also a Unit Leader
      current_roles=Login.current_login.roles.map(&:name)
      current_unit=unit_lead_by_academician if current_roles.include?("Unit Leader") && Programme.roots.map(&:name).include?(current_unit)
      
      if current_unit=="Pentadbiran"
        unit_members = Position.find(:all, :conditions=>['unit=? OR unit=? OR unit=? OR unit=?', "Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor"]).map(&:staff_id).uniq-[nil]+Position.find(:all, :conditions=>['unit=?', current_unit]).map(&:staff_id).uniq-[nil]
      elsif ["Teknologi Maklumat", "Pusat Sumber", "Kewangan & Akaun", "Sumber Manusia"].include?(current_unit) || Programme.roots.map(&:name).include?(current_unit)
        unit_members = Position.find(:all, :conditions=>['unit=?', current_unit]).map(&:staff_id).uniq-[nil]
      else #logistik & perkhidmatan inc."Unit Perkhidmatan diswastakan / Logistik" or other UNIT just in case - change of unit name, eg. Perpustakaan renamed as Pusat Sumber
        unit_members = Position.find(:all, :conditions=>['unit ILIKE(?)', "%#{current_unit}%"]).map(&:staff_id).uniq-[nil] 
      end
    else
      unit_members = []#Position.find(:all, :conditions=>['unit=?', 'Teknologi Maklumat']).map(&:staff_id).uniq-[nil]
    end
    unit_members    #collection of staff_id (member of a unit/dept)
  end
  
  #call this method if academician also lead a mgmt unit
  def unit_lead_by_academician
    main_tasks=Login.current_login.staff.position.tasks_main
    if main_tasks.include?("Ketua Unit")   
      mgmt_unit=main_tasks.scan(/Ketua Unit(.*),/)[0][0].strip
    else
      mgmt_unit=""
    end
    mgmt_unit
  end
  
#   def applicant_siblings
#     applicant_unit=applicant.position.unit
#     siblings=Position.find(:all, :conditions=>['unit=?', applicant_unit]).map(&:staff_id).uniq-[nil]
#     siblings+=Position.find(:all, :conditions=>['unit=?', "Pentadbiran"]).map(&:staff_id).uniq-[nil] if ["Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor"].include?(applicant_unit)
#     siblings
#   end
  
end
