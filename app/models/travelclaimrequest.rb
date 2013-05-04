class Travelclaimrequest < ActiveRecord::Base
  belongs_to :travelclaim
  belongs_to :travelrequest
  
 # has_many :travelclaimdetails, :dependent => :destroy
 # accepts_nested_attributes_for :travelclaimdetails, :reject_if => lambda { |a| a[:traveldetail_id].blank? }, :allow_destroy =>true
  
  
  def mileage
    Traveldetail.sum(:distance, :conditions => ["travelclaimrequest_id = ?", id])
  end
  
  def trcode_details # 13/11/2011-Shaliza added code for trcode no longer exists-->
    suid = travelrequest_id.to_a
    exists = Travelrequest.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if travelrequest_id == nil
      "-"
    elsif checker == []
      "Not Available"
    else
      travelrequest.trcode
    end
  end
  
  def destinantion_details # 13/11/2011-Shaliza added code for destination no longer exists-->
    suid = travelrequest_id.to_a
    exists = Travelrequest.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if travelrequest_id == nil
      "-"
    elsif checker == []
      "Not Available"
    else
      travelrequest.destination
    end
  end
  
  def purpose_details # 13/11/2011-Shaliza added code for purpose no longer exists-->
    suid = travelrequest_id.to_a
    exists = Travelrequest.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if travelrequest_id == nil
      "-"
    elsif checker == []
      "Not Available"
    else
      travelrequest.purpose
    end
  end
  
end
