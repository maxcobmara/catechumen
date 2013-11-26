class StaffAppraisalSkt < ActiveRecord::Base
  belongs_to :staff_appraisal
  
  before_save :set_to_nil_where_false, :set_review
  
  def set_to_nil_where_false
    if is_dropped != true
      self.dropped_on	= nil
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
end
