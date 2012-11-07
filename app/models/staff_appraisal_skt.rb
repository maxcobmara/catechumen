class StaffAppraisalSkt < ActiveRecord::Base
  belongs_to :staff_appraisal
  
  before_save :set_to_nil_where_false
  
  def set_to_nil_where_false
    if is_dropped != true
      self.dropped_on	= nil
    end
  end
end
