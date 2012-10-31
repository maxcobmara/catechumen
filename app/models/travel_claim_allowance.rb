class TravelClaimAllowance < ActiveRecord::Base
  belongs_to :travel_claim
  
  before_save :make_total
  
  def make_total
    self.total = quantity * amount
  end
  
  def allow_expend_type
    spend = (TravelClaimReceipt::ALLOWANCETYPE.find_all{|disp, value| value == expenditure_type}).map {|disp, value| disp}
    spend.to_s.titleize
  end
end
