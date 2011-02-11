class Assettrack < ActiveRecord::Base
  belongs_to :asset
  
  belongs_to :assetinassettrack, :class_name => 'Asset', :foreign_key => 'asset_id'
  belongs_to :staffinassettrack, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :isby, :class_name => 'Staff', :foreign_key => 'issuedby'
  belongs_to :assettrackreturn, :class_name => 'Staff', :foreign_key => 'returnedto'
 
  
  def bil
     v=1
    end
    
  def duration
    use_enddate.day - use_startdate.day
  end
  
end
