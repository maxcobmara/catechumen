class Travelclaim < ActiveRecord::Base
  
 # before_save :varmyass
  #traveclaim = survey, travelrequest = questions
  
  has_many :travelclaimrequests, :dependent => :destroy
  accepts_nested_attributes_for :travelclaimrequests, :reject_if => lambda { |a| a[:travelrequest_id].blank? }, :allow_destroy =>true
  
  has_many :travelclaimreceipts, :dependent => :destroy
  accepts_nested_attributes_for :travelclaimreceipts, :allow_destroy =>true
  
  has_many :travelallowances, :dependent => :destroy
  accepts_nested_attributes_for :travelallowances, :allow_destroy =>true
  
  
  #display on show.html.erb
  #belongs_to :travelrequest, :foreign_key => 'travelrequest_id'
  #belongs_to :travelclaim, :foreign_key => 'staff_id'
  belongs_to :hod,       :class_name => 'Staff', :foreign_key => 'hod_id'
  #belongs_to :travelcode,       :class_name => 'Travelrequest', :foreign_key => 'travelrequest_id'
  belongs_to :staff
  
  validates_presence_of :claimsmonth, :staff_id
  
  def varmyass
    self.ptclaimsvalue = value_km
  end
  
  def self.find_main
      Travelrequest.find(:all, :condition => ['travelrequest_id IS NULL'])
  end
  
  def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def total_claims
    if ptclaimsvalue == nil
     receipts
    else 
     receipts + ptclaimsvalue
    end
  end
  
  def receipts
    travelclaimreceipts.sum(:rvalue)
  end
  
 # This Stuff is for the mileage calculations try put other stuff above this
  def mo_mileage
    gettcr = Travelclaimrequest.find(:all, :conditions => ["travelclaim_id = ?", id], :select => :id).map(&:id)
    getkm = Traveldetail.find(:all, :conditions => ["travelclaimrequest_id IN (?)", gettcr], :select => :distance).map(&:distance)
    getkm.inject(:+)
  end
  
  def km500
    if mo_mileage < 501
      mo_mileage
    else
      500.0
    end
  end
  
  def km1000
    if mo_mileage < 501
      0.0
    elsif mo_mileage < 1001
      mo_mileage - 500
    else
      500
    end
  end
  
  def km1700
    if mo_mileage < 1001
      0.0
    elsif mo_mileage < 1701
      mo_mileage - 1000
    else
      700
    end
  end
  
  def kmmo
    if mo_mileage < 1701
      0.0
    else
      mo_mileage - 1700
    end
  end
  
  
  def sen_per_km500
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
   (km500 * sen_per_km500)/100
  end
  
  def value_km1000
   (km1000 * sen_per_km1000)/100
  end
  
  def value_km1700
   (km1700 * sen_per_km1700)/100
  end
  
  def value_kmmo
   (kmmo * sen_per_kmmo)/100
  end
  
  def value_km
    value_km500 + value_km1000 + value_km1700 + value_kmmo
  end
  

  def transport_details
    suid = staff_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if staff_id == nil
      "-"
    elsif checker == []
      "Not Available"
    else
      staff.transportclass_id
    end
  end
  
  def staff_details
    suid = staff_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if staff_id == nil
      "-"
    elsif checker == []
      "Not Available"
    else
      staff.staff_name_with_title
    end
  end
  
 
    
  
  
end
