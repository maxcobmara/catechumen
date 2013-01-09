class Assettrack < ActiveRecord::Base
  
  belongs_to :assetinassettrack, :class_name => 'Asset', :foreign_key => 'asset_id'
  belongs_to :borrower, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :isby, :class_name => 'Staff', :foreign_key => 'issuedby'
  belongs_to :assettrackreturn, :class_name => 'Staff', :foreign_key => 'returnedto'
 
  validates_presence_of :asset_id, :staff_id
  
  def bil
     v=1
    end
    
  def duration
    use_enddate - use_startdate
  end
  
  def borrower_details 
    check_kin {borrower.mykad_with_staff_name}
  end
  
end
