class StaffAppraisal < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_validation :set_year_to_start
  before_save :set_to_nil_where_false, :set_number_of_questions, :when_ppp_is_ppk
  
  
  belongs_to :appraised,      :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :eval1_officer,  :class_name => 'Staff', :foreign_key => 'eval1_by'
  belongs_to :eval2_officer,  :class_name => 'Staff', :foreign_key => 'eval2_by'
  
  has_many :staff_appraisal_skts, :dependent => :destroy
  accepts_nested_attributes_for :staff_appraisal_skts, :allow_destroy => true, :reject_if => lambda { |a| a[:description].blank? }
  
  has_many :evactivities, :foreign_key => 'appraisal_id', :dependent => :destroy
  accepts_nested_attributes_for :evactivities, :allow_destroy => true, :reject_if => lambda { |a| a[:evactivity].blank? }
  
  has_many :trainneeds, :foreign_key => 'evaluation_id', :dependent => :destroy
  accepts_nested_attributes_for :trainneeds, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
  
  
  validates_uniqueness_of :evaluation_year, :scope => :staff_id, :message => "Your evaluation for this year already exists"
  
  
  #before logic
  def set_to_nil_where_false
    if is_skt_submit != true
      self.skt_submit_on	= nil
    end
    
    if is_skt_endorsed != true
      self.skt_endorsed_on	= nil
    end
    
    if is_skt_pyd_report_done != true
      self.skt_pyd_report_on	= nil
    end
    
    if is_skt_ppp_report_done != true
      self.skt_ppp_report_on	= nil
    end
    
    if is_submit_for_evaluation == false
      self.submit_for_evaluation_on	= nil
    end
    
    if is_submit_e2 == false
      self.submit_e2_on	= nil
    end
    
    if is_complete == false
      self.is_completed_on	= nil
    end
  end
  
  def set_year_to_start
    self.evaluation_year = evaluation_year.at_beginning_of_year
  end
  
  
  
  
  #logic to set editable
  def edit_icon
    if evaluation_status == "SKT awaiting PPP endorsement" && staff_id == User.current_user.staff_id
      "noedit"
    elsif evaluation_status == "SKT awaiting PPP endorsement" && eval1_by == User.current_user.staff_id
      "approval.png"
    elsif evaluation_status == "SKT Review" && eval1_by == User.current_user.staff_id
      "noedit"
    elsif evaluation_status == "Ready for PPP SKT Report" && staff_id == User.current_user.staff_id
      "noedit"
    elsif evaluation_status == "PPP Report complete" && eval1_by == User.current_user.staff_id
      "noedit"
    elsif evaluation_status == "Submitted for Evaluation by PPP"&& staff_id == User.current_user.staff_id
      "noedit"
    elsif evaluation_status == "Submitted for Evaluation by PPP to PPK" && staff_id == User.current_user.staff_id
      "noedit"
    elsif evaluation_status == "Submitted by PPP for Evaluation  to PPK" && eval1_by == User.current_user.staff_id
      "noedit"
    elsif is_complete == true
      "noedit"
    else
      "edit.png"
    end
  end
  
  def evaluation_status
    if is_skt_submit != true
      "SKT being formulated"
    elsif is_complete == true
   		"Staff Appraisal complete"
    elsif is_skt_submit == true && is_skt_endorsed != true
      "SKT awaiting PPP endorsement"
    elsif is_skt_submit == true && is_skt_endorsed == true && is_skt_pyd_report_done != true
      "SKT Review"
    elsif is_skt_pyd_report_done == true && is_skt_ppp_report_done != true
      "Ready for PPP SKT Report"
    elsif is_skt_pyd_report_done == true && is_skt_ppp_report_done == true && is_submit_for_evaluation != true
      "PPP Report complete"
    elsif is_skt_ppp_report_done == true && is_submit_for_evaluation == true && is_submit_e2 != true
      "Submitted for Evaluation by PPP"
   	elsif is_submit_for_evaluation == true && is_submit_e2 == true
   	   "Submitted by PPP for Evaluation  to PPK"
    end
  end
  
  def set_number_of_questions
    self.g1_questions = 5
    if appraised.staffgrade.name.last(2).to_i <= 16
      self.g2_questions = 4
      self.g3_questions = 3
    elsif appraised.staffgrade.name.last(2).to_i >= 41
      self.g2_questions = 3
      self.g3_questions = 5
    else
      self.g2_questions = 3
      self.g3_questions = 4
    end
  end
  
  def person_type
    if appraised.staffgrade.name.last(2).to_i <= 16
      5
    elsif appraised.staffgrade.name.last(2).to_i >= 41
      3
    else
      4
    end
  end
  
  def person_type_description
    if appraised.staffgrade.name.last(2).to_i <= 16
      "SOKONGAN (II)"
    elsif appraised.staffgrade.name.last(2).to_i >= 41
      "PENGURUSAN DAN PROFESIONAL"
    else
      "SOKONGAN (I)"
    end
  end
  
  def show_ppk_in_show
    if is_submit_e2 == true
      "show"
    else
      "none"
    end
  end
  
  def when_ppp_is_ppk
    if eval1_by == eval2_by && e1_total != nil #> 1
      self.e2g1q1        =  e1g1q1
      self.e2g1q2        =  e1g1q2
      self.e2g1q3        =  e1g1q3
      self.e2g1q4        =  e1g1q4
      self.e2g1q5        =  e1g1q5
      self.e2g1_total    =  e1g1_total
      self.e2g1_percent  =  e1g1_percent
      self.g2_questions  =  g3_questions
      self.e2g2q1        =  e1g2q1
      self.e2g2q2        =  e1g2q2
      self.e2g2q3        =  e1g2q3
      self.e2g2q4        =  e1g2q4
      self.e2g2_total    =  e1g2_total
      self.e2g2_percent  =  e1g2_percent
      self.e2g3q1        =  e1g3q1
      self.e2g3q2        =  e1g3q2
      self.e2g3q3        =  e1g3q3
      self.e2g3q4        =  e1g3q4
      self.e2g3q5        =  e1g3q5
      self.e2g3_total    =  e1g3_total
      self.e2g3_percent  =  e1g3_percent
      self.e2g4          =  e1g4
      self.e2g4_percent  =  e1g4_percent
      self.e2_total      =  e1_total
      self.e2_years      =  e1_years
      self.e2_months     =  e1_months
      self.is_submit_e2  =  false
      self.submit_e2_on  =  Date.today
    end 
  end
  
  
  
  
  # calculations for printed form not used anymore
  #partiii
  def part3_eval1_calced
    eval1_quantity + eval1_quality + eval1_quality + eval1_time + eval1_effective
  end 
  def part3_eval1_calced_percent
    ((part3_eval1_calced)/50)*50
  end 
  def part3_eval2_calced
    eval2_quantity + eval2_quality + eval2_quality + eval2_time + eval2_effective
  end 
  def part3_eval2_calced_percent
    ((part3_eval2_calced)/50)*50
  end
  #partiv
  def part4_eval1_calced
    eval1_knowledge + eval1_rule + eval1_communicate
  end 
  def part4_eval1_calced_percent
    ((part4_eval1_calced)/30)*25
  end 
  def part4_eval2_calced
    eval2_knowledge + eval2_rule + eval2_communicate
  end 
  def part4_eval2_calced_percent
    ((part4_eval2_calced)/30)*25
  end
  #partv
  def part5_eval1_calced
    eval1_leader + eval1_manage + eval1_discipline + eval1_proactive + eval1_relate
  end 
  def part5_eval1_calced_percent
    ((part5_eval1_calced)/50)*20
  end 
  def part5_eval2_calced
    eval2_leader + eval2_manage + eval2_discipline + eval2_proactive + eval2_relate
  end 
  def part5_eval2_calced_percent
    ((part5_eval2_calced)/50)*20
  end
  
  #partvi
  def part6_eval1_calced_percent
    ((eval1_part_ii)/10)*5
  end
  def part6_eval2_calced_percent
    ((eval2_part_ii)/10)*5
  end
  
  def total1
    part3_eval1_calced_percent + part4_eval1_calced_percent + part5_eval1_calced_percent + part6_eval1_calced_percent
  end
  def total2
    part3_eval2_calced_percent + part4_eval2_calced_percent + part5_eval2_calced_percent + part6_eval2_calced_percent
  end
  def t1t2_average
    (e1_total + e2_total)/2
  end
  
  
  
end
