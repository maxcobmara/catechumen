class Assetloss < ActiveRecord::Base
  belongs_to :part,     :foreign_key => 'part_id' 
  belongs_to :location, :foreign_key => 'losslocation_id' 
  #belongs_to :staff, :foreign_key => 'staff_id' 
  belongs_to :asset
  
  #Residence
  belongs_to :assetlocation,  :class_name => 'Location', :foreign_key => 'losslocation_id'
  
  #Staff
  belongs_to :laststaff,        :class_name => 'Staff', :foreign_key => 'lossstafflast_id' 
  belongs_to :hod,              :class_name => 'Staff', :foreign_key => 'hod_id'
  belongs_to :enforce,          :class_name => 'Staff', :foreign_key => 'newrule_id'
  belongs_to :officer,          :class_name => 'Staff', :foreign_key => 'endorsed_hod_by'
  
  validates_presence_of :reportcode, :sio_id, :losstype
  
  
  #------Autocomplete on Asset
  def asset_name
    asset.name if asset
  end
  
  def asset_name=(name)
    self.asset = Asset.find_by_code_asset(code_asset) unless name.blank?
  end
  
  
  
  #------
  
   def self.find_main
     Asset.find(:all, :condition => ['asset_id IS NULL'])
   end
   
   def self.find_main
      Part.find(:all, :condition => ['part_id IS NULL'])
   end
    
    def self.find_main
        Location.find(:all, :condition => ['location_id IS NULL'])
    end
    
    def self.find_main
        Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
  
  LOSS = [
        #  Displayed       stored in db
        [ "Cash","Cash" ],
        [ "Asset","Asset" ],
        [ "Supplies","Supplies" ]
  ]
  
  
  MONEY = [
        #  Displayed       stored in db
        [ "Tunai","Tunai" ],
        [ "Cek","Cek" ],
        [ "Wang Pos","Wang Pos" ],
        [ "Kiriman Wang","Kiriman Wang" ],
        [ "Lain-Lain","Lain-Lain" ]
        
  ]
  
  #association error checking
    def asset_details         
      check_kin {asset.code_asset}
    end
  
    def location_details 
      check_kin {location.location_list}
    end
  
    def last_staff_to_handle
      check_kin {laststaff.staff_name_with_position}
    end
  
    def hod_details 
      check_kin {hod.staff_name_with_position}
    end
   
    def officer_details 
      check_kin {officer.staff_name_with_position}
    end
end
