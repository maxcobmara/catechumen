class Travelclaimrequest < ActiveRecord::Base
  belongs_to :travelclaim
  belongs_to :travel_request
  
  has_many :traveldetails, :foreign_key => 'travelclaimrequest_id', :dependent => :destroy
  accepts_nested_attributes_for :traveldetails, :allow_destroy => true#, :reject_if => lambda { |a| a[:travelday].blank? }#
  
  
  def mileage
    Traveldetail.sum(:distance, :conditions => ["travelclaimrequest_id = ?", id])
  end
  
  def unclaimed_travel_requests
    Travelrequest.find(:all, :condition => ['staff_id =?', User.current_user.staff_id])
  end
  
end
