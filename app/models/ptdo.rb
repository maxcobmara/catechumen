class Ptdo < ActiveRecord::Base
  before_save  :whoami
  
  belongs_to  :ptschedule
  belongs_to  :staff
  belongs_to  :applicant, :class_name => 'Staff',   :foreign_key => 'staff_id'
  belongs_to  :replacement, :class_name => 'Staff', :foreign_key => 'replacement_id'
  has_many    :staff_appraisals, :through => :staff
  
  #named_scope :all2,  :conditions => ['final_approve=? and ptschedule_id IN(?)', true, Ptschedule.find(:all, :conditions => ['budget_ok=?', true].map(&:id)]
  
  def self.all2
    Ptdo.find(:all, :conditions => ['final_approve=? and ptschedule_id IN(?)', true, Ptschedule.find(:all, :conditions => ['budget_ok=?', true]).map(&:id)],  :order => 'ptschedule_id DESC')
  end
  
  def self.filters
    filtering=[{:scope => "all2", :label => I18n.t('ptdos.all_records')}]
    Ptdo.all2.group_by{|x|x.ptschedule.start.strftime("%Y")}.each do |year2, ptdos|
      filtering << {:scope=>"#{year2}", :label =>"#{year2}"}
    end
    filtering
  end
  
  def whoami
    #self.staff_id = Login.current_login.staff.id
    self.ptcourse_id = ptschedule.ptcourse.id
  end
  
  def self.search(search)
    if search
       searched_ptcourses_ids=Ptcourse.find(:all, :conditions =>['name ILIKE (?)', "%#{search}%"]).map(&:id)
       searched_staff_ids=Staff.find(:all, :conditions =>['name ILIKE (?)', "%#{search}%"]).map(&:id)
       ptdos=Ptdo.find(:all, :conditions => ['ptcourse_id IN(?) or staff_id IN(?)', searched_ptcourses_ids, searched_staff_ids])
    else 
      ptdos=Ptdo.find(:all, :order=>'ptschedule_id ASC')
    end
  end
  
  def apply_dept_status
    if (unit_approve == false || dept_approve == false || final_approve == false)
      I18n.t("ptdos.application_rejected")#"Application Rejected"
    elsif unit_approve.nil? == true
      I18n.t("ptdos.awaiting_unit_approval")#"Awaiting Unit Approval"
    elsif unit_approve == true && dept_approve.nil? == true
      I18n.t("ptdos.approved_unit_head_await_dept_approval")#"Approved by Unit head, awaiting Dept approval"
    elsif dept_approve == true && dept_approve == true && final_approve.nil? == true
      I18n.t("ptdos.approved_dept_head_await_pengarah_approval")#"Approved by Dept head, awaiting Pengarah approval"
    elsif dept_approve == true && dept_approve == true && final_approve == true && trainee_report.nil? == true
      I18n.t("ptdos.all_approvals_complete")#"All approvals complete"
    elsif dept_approve == true && dept_approve == true && final_approve == true && trainee_report.nil? == false
      I18n.t("ptdos.report_submitted")#"Report Submitted"
    else
      I18n.t("ptdos.status_not_available")#"Status Not Available"
    end
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
  
  PAYMENT=[
    #  Displayed       stored in db
    [I18n.t('ptdos.local_order'), 1],
    [I18n.t('ptdos.cash'), 2]
  ]
  
  def render_payment
    (Ptdo::PAYMENT.find_all{|disp, value| value == payment}).map{|disp, value| disp}
  end
  
end
