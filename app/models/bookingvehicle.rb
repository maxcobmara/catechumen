class Bookingvehicle < ActiveRecord::Base
#Link to Model Staff
  belongs_to :staffname,      :class_name => 'Staff',   :foreign_key => 'applicant'
  belongs_to :approver,      :class_name => 'Staff',   :foreign_key => 'approver_name'
  belongs_to :endorser,      :class_name => 'Staff',   :foreign_key => 'endorse_name'
  belongs_to :vehicle,      :class_name => 'Officecar',   :foreign_key => 'vehicle_id'
  belongs_to :driver,      :class_name => 'Staff',   :foreign_key => 'driver_name'
  
 
  
  APPROVED = [
        #  Displayed       stored in db
        [ "Approved","1"],
        [ "Not Approved","2"]
  ]
  
  ENDORSED = [
        #  Displayed       stored in db
        [ "Endorsed","1"],
        [ "Not Endorsed","2"]
  ]
end
