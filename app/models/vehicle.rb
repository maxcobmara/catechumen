class Vehicle < ActiveRecord::Base
  
  before_destroy :travel_own_car_exist
  belongs_to :staffvehicle, :class_name => 'Staff', :foreign_key => 'staff_id'
  
  private
  
    def  travel_own_car_exist
      travellings_own_car = TravelRequest.find(:all, :conditions => ['staff_id=? and own_car=?', staff_id, true]).count
      if travellings_own_car > 0 
        return false
        #errors.add(:base, I18n.t('vehicles.is_not_removable'))
      else
        return true
      end
    end
  
end 