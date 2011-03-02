class Travelclaim < ActiveRecord::Base
  
  #before_save :varmyass
  #traveclaim = survey, travelrequest = questions
  
  has_many :travelclaimrequests, :dependent => :destroy
  accepts_nested_attributes_for :travelclaimrequests, :reject_if => lambda { |a| a[:travelrequest_id].blank? }, :allow_destroy =>true
  
  has_many :travelclaimreceipts, :dependent => :destroy
  accepts_nested_attributes_for :travelclaimreceipts, :allow_destroy =>true
  
  
  #display on show.html.erb
  #belongs_to :travelrequest, :foreign_key => 'travelrequest_id'
  #belongs_to :travelclaim, :foreign_key => 'staff_id'
  #belongs_to :hod,       :class_name => 'Staff', :foreign_key => 'hod_id'
  #belongs_to :travelcode,       :class_name => 'Travelrequest', :foreign_key => 'travelrequest_id'
  belongs_to :staff
  
  validates_presence_of :claimsmonth, :staff_id
  
  def self.find_main
      Travelrequest.find(:all, :condition => ['travelrequest_id IS NULL'])
  end
  
  def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  
  def distance_value
   d = distance
   if d = 0 || d = 'null'
     0
   elsif d > 0 && d < 501
     [d * 0.7]
   elsif d < 1001
      [(500 * 0.7) + ((distance-500)* 0.5)]
   elsif d < 1701
      [(500 * 0.7) + ((distance-500)* 0.5) + ((distance-1000)* 0.25)]
   else
      [(500 * 0.7) + ((distance-500)* 0.5) + ((distance-1000)* 0.25) + ((distance - 1700) * 0.1)]
   end
  end
  
  def total_claims
    distancevalue + ptclaimsvalue + allclaimsvalue + othclaimsvalue
  end
  
  
  
  def varmyass
    self.distancevalue = distance_value
  end
    
  
  
end
