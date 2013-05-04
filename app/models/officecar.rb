class Officecar < ActiveRecord::Base

 has_many :vehicle,      :class_name => 'Bookingvehicle',   :foreign_key => 'vehicle_id'
 has_many :vehicleoffice,      :class_name => 'Travelrequest',   :foreign_key => 'asset_id'
 
  def bil
      v=1
   end
 
def car
	"#{car_regno} - #{modelcar}"
end 
CAR_TYPE = [
           #  Displayed       stored in db
           [ "Spanco", 1 ],
           [ "Operation", 2 ]
           ]
		   
CAR_CLASS = [
           #  Displayed       stored in db
           [ "A", 1 ],
           [ "B", 2 ],
		       [ "C", 3 ],
		       [ "D", 4],
		       [ "E", 5 ]
           ]
           
#---------------Search--------------------------------------------------------------------------------

  def self.search(search)
    if search
      @officecar = Officecar.find(:all, :conditions => ["car_regno LIKE ? or modelcar LIKE ?", "%#{search}%","%#{search}%"])
    else
      @officecar = Officecar.find(:all)
    end
  end
end
