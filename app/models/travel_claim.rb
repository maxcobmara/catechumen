class TravelClaim < ActiveRecord::Base
  
  before_save :set_to_nil_where_false, :set_total
  
  belongs_to :staff
  belongs_to :approver,           :class_name => 'Staff',      :foreign_key => 'approved_by'
  
  has_many :travel_requests
  accepts_nested_attributes_for :travel_requests
  
  has_many :travel_claim_receipts, :dependent => :destroy
  accepts_nested_attributes_for :travel_claim_receipts, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy =>true
  
  has_many :travel_claim_logs, :dependent => :destroy
  accepts_nested_attributes_for :travel_claim_logs, :reject_if => lambda { |a| a[:mileage].blank? }, :allow_destroy =>true
  
  has_many :travel_claim_allowances, :dependent => :destroy
  accepts_nested_attributes_for :travel_claim_allowances, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy =>true
  
  
  
  def set_to_nil_where_false
    if is_submitted == false
      self.submitted_on	= nil
    end
  end
  
  def set_total
    self.total = total_claims
  end
  
  
  
  
  
  def to_be_paid
    if advance == nil
      total_claims
    else
      total_claims - advance
    end
  end
  
  def total_claims 
     receipts + allowas + value_km
  end
   
  def receipts
    other_claims_total + public_transport_totals
  end
  
  def allowas
    travel_claim_allowances.sum(:total)
  end
  
  
  
  
  #items for claimprint
  
  def km500
    if total_mileage == nil 
      0.0 
    elsif total_mileage != nil && total_mileage < 501
      total_mileage
    else
      500
    end
  end
  
  def km1000
    if total_mileage == nil || total_mileage < 501
      0.0
    elsif total_mileage < 1001
      total_mileage - 500
    else
      500
    end
  end
  
  def km1700
    if total_mileage == nil || total_mileage < 1001
      0.0
    elsif total_mileage < 1701
      total_mileage - 1000
    else
      700
    end
  end
  
  def kmmo
    if total_mileage == nil || total_mileage < 1701
      0.0
    else
      total_mileage - 1700
    end
  end
  
  
  def sen_per_km500  #hack into a db
    if staff.transportclass_id == 'A'
      70
    elsif staff.transportclass_id == 'B'
      60
    elsif staff.transportclass_id == 'C'
      50
    elsif staff.transportclass_id == 'D'
      45
    elsif staff.transportclass_id == 'E'  
      40
    else 
      0
    end
  end
  
  def sen_per_km1000
    if staff.transportclass_id == 'A'
      65
    elsif staff.transportclass_id == 'B'
      55
    elsif staff.transportclass_id == 'C'
      45
    elsif staff.transportclass_id == 'D'
      40
    elsif staff.transportclass_id == 'E'  
      35
    else 
      0
    end
  end
  
  def sen_per_km1700
    if staff.transportclass_id == 'A'
      55
    elsif staff.transportclass_id == 'B'
      50
    elsif staff.transportclass_id == 'C'
      40
    elsif staff.transportclass_id == 'D'
      35
    elsif staff.transportclass_id == 'E'  
      30
    else 
      0
    end
  end
  
  def sen_per_kmmo
    if staff.transportclass_id == 'A'
      50
    elsif staff.transportclass_id == 'B'
      45
    elsif staff.transportclass_id == 'C'
      35
    elsif staff.transportclass_id == 'D'
      30
    elsif staff.transportclass_id == 'E'  
      25
    else 
      0
    end
  end
  
  def value_km500
    if total_mileage != nil
     (km500 * sen_per_km500)/100
    end
  end
  
  def value_km1000
    if total_mileage != nil
      (km1000 * sen_per_km1000)/100
    end
  end
  
  def value_km1700
    if total_mileage != nil
      (km1700 * sen_per_km1700)/100
    end
  end
  
  def value_kmmo
    if total_mileage != nil
      (kmmo * sen_per_kmmo)/100
    end
  end
  
  def value_km
    if total_mileage != nil
      value_km500 + value_km1000 + value_km1700 + value_kmmo
    end
  end
  
  
  
  #allowances
  
  def allowance_totals
    travel_claim_allowances.sum(:total, :conditions => ["expenditure_type IN (?)", [21,22,23] ])
  end
  
  def hotel_totals
    travel_claim_allowances.sum(:total, :conditions => ["expenditure_type IN (?)", [31,32,33] ])
  end
  
  
  
  #public transport
  def taxi_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 11]).map(&:receipt_code).join(", ")
  end
  def taxi_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 11])
  end
  
  def bus_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 12]).map(&:receipt_code).join(", ")
  end
  def bus_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 12])
  end
  
  def train_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 13]).map(&:receipt_code).join(", ")
  end
  def train_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 13])
  end
  
  def ferry_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 14]).map(&:receipt_code).join(", ")
  end
  def ferry_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 14])
  end
  
  def plane_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 15]).map(&:receipt_code).join(", ")
  end
  def plane_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 15])
  end
  
  def public_transport_totals
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type IN (?)", [11,12,13,14,15] ])
  end
  
  def exchange_loss_totals
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 99 ]) * 0.03
  end
  

  
  
  #Other 
  def toll_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 41]).map(&:receipt_code).join(", ")
  end
  def toll_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 41])
  end
  
  def parking_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 42]).map(&:receipt_code).join(", ")
  end
  def parking_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 42])
  end
  
  def laundry_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 43]).map(&:receipt_code).join(", ")
  end
  def laundry_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 43])
  end
  
  def pos_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 44]).map(&:receipt_code).join(", ")
  end
  def pos_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 44])
  end
  
  def comms_receipts
    travel_claim_receipts.find(:all, :select => 'receipt_code', :conditions => ["expenditure_type = ?", 45]).map(&:receipt_code).join(", ")
  end
  def comms_receipts_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 45])
  end
  
  def other_claims_total
    travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type IN (?)", [41,42,43,44,45] ]) + exchange_loss_totals
  end
  
  def total_mileage
    #other_claims_total + public_transport_totals
    travel_claim_logs.sum(:mileage)
  end
  
  
  


    #[ "Telefon/Teleks/Fax",45 ],
  
  
  
  
  
  #  
end
