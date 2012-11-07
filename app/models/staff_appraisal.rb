class StaffAppraisal < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_validation :set_year_to_start
  before_save :set_to_nil_where_false, :set_number_of_questions
  
  
  belongs_to :appraised,      :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :eval1_officer,  :class_name => 'Staff', :foreign_key => 'eval1_by'
  belongs_to :eval2_officer,  :class_name => 'Staff', :foreign_key => 'eval2_by'
  
  has_many :staff_appraisal_skts, :dependent => :destroy
  accepts_nested_attributes_for :staff_appraisal_skts, :reject_if => lambda { |a| a[:description].blank? }
  
  has_many :evactivities, :foreign_key => 'appraisal_id', :dependent => :destroy
  accepts_nested_attributes_for :evactivities, :reject_if => lambda { |a| a[:evactivity].blank? }
  
  has_many :trainneeds, :foreign_key => 'evaluation_id', :dependent => :destroy
  accepts_nested_attributes_for :trainneeds, :reject_if => lambda { |a| a[:name].blank? }
  
  
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
      self.is_complete_on	= nil
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
    else
      "edit.png"
    end
  end
  
  def evaluation_status
    if is_skt_submit != true
      "SKT being formulated"
    elsif is_skt_submit == true && is_skt_endorsed != true
      "SKT awaiting PPP endorsement"
    elsif is_skt_submit == true && is_skt_endorsed == true && is_skt_pyd_report_done != true
      "SKT Review"
    elsif is_skt_pyd_report_done == true && is_skt_ppp_report_done != true
      "Ready for PPP SKT Report"
    elsif is_skt_pyd_report_done == true && is_skt_ppp_report_done == true && is_submit_for_evaluation != true
      "PPP Report complete"
    elsif is_skt_ppp_report_done == true && is_submit_for_evaluation == true
      "Submitted for Evaluation by PPP"
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
      "Pink"
    elsif appraised.staffgrade.name.last(2).to_i >= 41
      "Green"
    else
      "Yellow"
    end
  end
  
  
  # calculations for printed form
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
    (total1 + total2)/2
  end
  
  
  
end
