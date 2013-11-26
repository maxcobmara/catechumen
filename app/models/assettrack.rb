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
    suid = staff_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists     
   
    if staff_id == nil
       "" 
    elsif checker == []
      "Staff No Longer Exists" 
    else
      borrower.mykad_with_staff_name
    end
  end
  
end
