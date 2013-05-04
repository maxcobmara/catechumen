class Traveldetail < ActiveRecord::Base
  belongs_to :travelrequest, :foreign_key => 'travelrequest_id'
#  has_many :travelclaimdetails
  def bil
     v=1
  end
  
  def mileage
    traveldetail.sum(:distance)
  end
  
 
  
 
  
end
