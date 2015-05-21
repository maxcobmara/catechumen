class StaffAppraisalSkt < ActiveRecord::Base
  belongs_to :staff_appraisal
  
  before_save :set_to_nil_where_false, :set_review
  validates_presence_of :acheivment, :progress, :notes, :if => :xtvt_not_dropped?
  #ref : http://homeonrails.com/2012/10/validating-nested-associations-in-rails/
  #note : conditions on both sides 1)Staff Appraisal - 'is_skt_pyd_report_done' must TRUE  2)Staff Appraisal SKT - consider only VALID one ('is_dropped' != true)
  validates_presence_of :description, :indicator, :target
  
  def xtvt_not_dropped?
    (is_dropped!= true && half==1 && staff_appraisal.is_skt_endorsed == true) || (_destroy!=true && half==2) 
  end
  
  def set_to_nil_where_false
    if is_dropped != true
      self.dropped_on	= nil
    end
    if is_dropped==true
      self.acheivment=''
      self.progress=nil
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
