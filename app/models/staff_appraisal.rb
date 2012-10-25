class StaffAppraisal < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_to_nil_where_false
  
  belongs_to :appraised,      :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :eval1_officer,  :class_name => 'Staff', :foreign_key => 'evaluation1_by'
  belongs_to :eval2_officer,  :class_name => 'Staff', :foreign_key => 'evaluation2_by'
  
  has_many :evactivities, :foreign_key => 'appraisal_id', :dependent => :destroy
  accepts_nested_attributes_for :evactivities, :reject_if => lambda { |a| a[:evactivity].blank? }
  
  has_many :trainneeds, :foreign_key => 'evaluation_id', :dependent => :destroy
  accepts_nested_attributes_for :trainneeds, :reject_if => lambda { |a| a[:name].blank? }
  
  #before logic
  def set_to_nil_where_false
    if submit_for_evaluation1 == false
      self.submit_for_appraisal1_on	= nil
    end
    
    if submit_for_evaluation2 == false
      self.submit_for_evaluation2_on	= nil
    end
    
    if is_complete == false
      self.is_complete_on	= nil
    end
  end
  
  
  
  
  #logic to set editable
  def editable_page
    if submit_for_evaluation1 == false && staff_id == User.current_user.staff_id
      "edit"
    elsif submit_for_evaluation1 == true && evaluation1_by == User.current_user.staff_id && submit_for_evaluation2 != true
      "edit"
    elsif submit_for_evaluation2 == true && evaluation2_by == User.current_user.staff_id
      "edit"
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
