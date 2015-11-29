class StaffAppraisalSkt < ActiveRecord::Base
  belongs_to :staff_appraisal
  
  before_save :set_to_nil_where_false, :set_review, :at_least_one_indicator_target_exist,  :new_cost_must_complete, :new_quality_must_complete, :new_time_must_complete, :new_quantity_must_complete
  validates_presence_of :achievement_quality, :progress_quality, :if => :xtvt_not_dropped_quality?
  validates_presence_of :achievement_time, :progress_time, :if => :xtvt_not_dropped_time?
  validates_presence_of :achievement_quantity, :progress_quantity, :if => :xtvt_not_dropped_quantity?
  validates_presence_of :achievement_cost, :progress_cost, :if => :xtvt_not_dropped_cost?
  #ref : http://homeonrails.com/2012/10/validating-nested-associations-in-rails/
  #note : conditions on both sides 1)Staff Appraisal - 'is_skt_pyd_report_done' must TRUE  2)Staff Appraisal SKT - consider only VALID one ('is_dropped' != true)
  validates_presence_of :description
  validates_presence_of :target_quality, :if => :indicator_desc_exist?
  validates_presence_of :target_time, :if => :indicator_desc2_exist?
  validates_presence_of :target_quantity, :if => :indicator_desc3_exist?
  validates_presence_of :target_cost, :if => :indicator_desc4_exist?
  def indicator_desc_exist?
     !indicator_desc_quality.blank? #half==1 &&
  end
  def indicator_desc2_exist?
     !indicator_desc_time.blank?
  end
  def indicator_desc3_exist?
   !indicator_desc_quantity.blank?
  end
  def indicator_desc4_exist?
    !indicator_desc_cost.blank?
  end
  
  #FOR NEWly inserted xtvt, mid - year SKT review (render fields although record not yet saved due to errors)
  def at_least_one_indicator_target_exist 
    #when not even 1 set exist(indicator_desc+target+achievement+progress )
    if half==2 && (indicator_desc_quality.blank? && target_quality.blank? && achievement_quality.blank? && progress_quality.blank?) && (indicator_desc_time.blank? && target_time.blank? && achievement_time.blank? && progress_time.blank?) && (indicator_desc_quantity.blank? && target_quantity.blank? && achievement_quantity.blank? && progress_quantity.blank?) && (indicator_desc_cost.blank? && target_cost.blank? && achievement_cost.blank? && progress_cost.blank?)
      return false 
      errors.add("aa","error la")
#     elsif id.nil? && half==2 
#       
#       #when user selected 'Sent to PPP for Report' - with INCOMPLETE NEWly inserted xtvt(not yet saved) - (render fields although record not yet saved due to errors)
#       #RESTRICTIONS : requires 'Target fields' to be completed for repeating fields to be rendered when error occurs
#       if ( !indicator_desc_quality.blank? && !target_quality.blank? && !achievement_quality.blank? && !progress_quality.blank?)
#         return true
#       else
#         return false
#       end
#       if ( !indicator_desc_time.blank? && !target_time.blank? && !achievement_time.blank? && !progress_time.blank?)
#         return true
#       else
#         return false
#       end
#       if ( !indicator_desc_quantity.blank? && !target_quantity.blank? && !achievement_quantity.blank? && progress_quantity.blank?)
#         return true
#       else
#         return false
#       end
#       if ( !indicator_desc_cost.blank? && !target_cost.blank? && !achievement_cost.blank? && !progress_cost.blank?)
#         return true
#       else
#         return false
#       end

    elsif half==1 && (indicator_desc_quality.blank? && target_quality.blank?) && (indicator_desc_time.blank? && target_time.blank?) && (indicator_desc_quantity.blank? && target_quantity.blank?) && (indicator_desc_cost.blank? && target_cost.blank?)
      return false
    end
  end
  
  #when user selected 'Sent to PPP for Report' - with INCOMPLETE NEWly inserted xtvt(not yet saved) - (render fields although record not yet saved due to errors)
  #RESTRICTIONS : requires 'Target fields' to be completed for repeating fields to be rendered when error occurs
  ###note : checking for target not required here - refer above targets.. validations
  def new_quality_must_complete
    if (id.nil? && half==2)
      if (!indicator_desc_quality.blank? && !target_quality.blank? && !achievement_quality.blank? && !progress_quality.blank?)
        return true
      elsif (!indicator_desc_quality.blank? && target_quality.blank? && achievement_quality.blank? && progress_quality.blank?) || (!indicator_desc_quality.blank? && !target_quality.blank? && achievement_quality.blank? && progress_quality.blank?) || (!indicator_desc_quality.blank? && !target_quality.blank? && !achievement_quality.blank? && progress_quality.blank?) || (!indicator_desc_quality.blank? && !target_quality.blank? && achievement_quality.blank? && !progress_quality.blank?) || (indicator_desc_quality.blank? && !target_quality.blank? && !achievement_quality.blank? && !progress_quality.blank?)||  (indicator_desc_quality.blank? && target_quality.blank? && !achievement_quality.blank? && !progress_quality.blank?) || (indicator_desc_quality.blank? && target_quality.blank? && achievement_quality.blank? && !progress_quality.blank?) || (indicator_desc_quality.blank? && target_quality.blank? && !achievement_quality.blank? && progress_quality.blank?) 
        return false
      end
    end 
  end
  def new_time_must_complete
    if (id.nil? && half==2)
      if (!indicator_desc_time.blank? && !target_time.blank? && !achievement_time.blank? && !progress_time.blank?)
        return true
      elsif (!indicator_desc_time.blank? && target_time.blank? && achievement_time.blank? && progress_time.blank?) || (!indicator_desc_time.blank? && !target_time.blank? && achievement_time.blank? && progress_time.blank?) || (!indicator_desc_time.blank? && !target_time.blank? && !achievement_time.blank? && progress_time.blank?) || (!indicator_desc_time.blank? && !target_time.blank? && achievement_time.blank? && !progress_time.blank?) || (indicator_desc_time.blank? && !target_time.blank? && !achievement_time.blank? && !progress_time.blank?) || (indicator_desc_time.blank? && target_time.blank? && !achievement_time.blank? && !progress_time.blank?)   || (indicator_desc_time.blank? && target_time.blank? && achievement_time.blank? && !progress_time.blank?) || (indicator_desc_time.blank? && target_time.blank? && !achievement_time.blank? && progress_time.blank?) 
        return false
      end
    end
  end
  def new_quantity_must_complete
    if (id.nil? && half==2)
      if (!indicator_desc_quantity.blank? && !target_quantity.blank? && !achievement_quantity.blank? && !progress_quantity.blank?)
        return true
      elsif (!indicator_desc_quantity.blank? && target_quantity.blank? && achievement_quantity.blank? && progress_quantity.blank?) || (!indicator_desc_quantity.blank? && !target_quantity.blank? && achievement_quantity.blank? && progress_quantity.blank?) || (!indicator_desc_quantity.blank? && !target_quantity.blank? && !achievement_quantity.blank? && progress_quantity.blank?) || (!indicator_desc_quantity.blank? && !target_quantity.blank? && achievement_quantity.blank? && !progress_quantity.blank?) || (indicator_desc_quantity.blank? && !target_quantity.blank? && !achievement_quantity.blank? && !progress_quantity.blank?) ||  (indicator_desc_quantity.blank? && target_quantity.blank? && !achievement_quantity.blank? && !progress_quantity.blank?) || (indicator_desc_quantity.blank? && target_quantity.blank? && achievement_quantity.blank? && !progress_quantity.blank?) || (indicator_desc_quantity.blank? && target_quantity.blank? && !achievement_quantity.blank? && progress_quantity.blank?) 
        return false
      end
    end
  end
  def new_cost_must_complete
    if ( id.nil? && half==2 )
      if (!indicator_desc_cost.blank? && !target_cost.blank? && !achievement_cost.blank? && !progress_cost.blank?)
        return true
      elsif (!indicator_desc_cost.blank? && target_cost.blank? && achievement_cost.blank? && progress_cost.blank?) || (!indicator_desc_cost.blank? && !target_cost.blank? && achievement_cost.blank? && progress_cost.blank?) || (!indicator_desc_cost.blank? && !target_cost.blank? && !achievement_cost.blank? && progress_cost.blank?) || (!indicator_desc_cost.blank? && !target_cost.blank? && achievement_cost.blank? && !progress_cost.blank?) || (indicator_desc_cost.blank? && !target_cost.blank? && !achievement_cost.blank? && !progress_cost.blank?) || (indicator_desc_cost.blank? && target_cost.blank? && !achievement_cost.blank? && !progress_cost.blank?)  || (indicator_desc_cost.blank? && target_cost.blank? && achievement_cost.blank? && !progress_cost.blank?) || (indicator_desc_cost.blank? && target_cost.blank? && !achievement_cost.blank? && progress_cost.blank?) 
        return false
      end
    end
  end
  ###
 
  #FOR SAVED xtvt (half==1 OR half==2)
  def xtvt_not_dropped_quality?
   ( (is_dropped!= true && half==1 && staff_appraisal.is_skt_endorsed == true) || (_destroy!=true && half==2) ) && ( !indicator_desc_quality.blank? && !target_quality.blank?)
  end
  def xtvt_not_dropped_time?
   ( (is_dropped!= true && half==1 && staff_appraisal.is_skt_endorsed == true) || (_destroy!=true && half==2) ) && ( !indicator_desc_time.blank? && !target_time.blank?)
  end
  def xtvt_not_dropped_quantity?
   ( (is_dropped!= true && half==1 && staff_appraisal.is_skt_endorsed == true) || (_destroy!=true && half==2) ) && ( !indicator_desc_quantity.blank? && !target_quantity.blank?)
  end
  def xtvt_not_dropped_cost?
   ( (is_dropped!= true && half==1 && staff_appraisal.is_skt_endorsed == true) || (_destroy!=true && half==2) ) && ( !indicator_desc_cost.blank? && !target_cost.blank?)
  end
  
  def set_to_nil_where_false
    if is_dropped != true
      self.dropped_on	= nil
    end
    if is_dropped==true
      #self.acheivment=''
      #self.progress=nil
      self.achievement_quality=''
      self.progress_quality=nil 
      self.notes_quality=''
      self.achievement_time=''
      self.progress_time=nil 
      self.notes_time=''
      self.achievement_quantity=''
      self.progress_quantity=nil 
      self.notes_quantity=''
      self.achievement_cost=''
      self.progress_cost=nil 
      self.notes_cost=''
    end
  end
  
  def set_review
    #if staff_appraisal.is_skt_endorsed == true
      #self.half = 2
   # end
    if staff_appraisal.is_skt_submit == true && staff_appraisal.is_skt_endorsed == nil
      self.half = 1
    elsif staff_appraisal.is_skt_submit != true && staff_appraisal.is_skt_endorsed == nil
    	self.half = 1
    end
    if staff_appraisal.is_skt_endorsed == true && self.half == nil
    	self.half = 2
    end
  end
  
  def render_indicator
    (StaffAppraisalSkt::INDICATORS.find_all{|disp, value| value == indicator}).map {|disp, value| disp}
  end
  
  INDICATORS=[
    [I18n.t('evaluation.skt.quality'), 1],
    [I18n.t('evaluation.skt.time'), 2],
    [I18n.t('evaluation.skt.quantity'), 3],
    [I18n.t('evaluation.skt.cost'), 4]
    ]
end
