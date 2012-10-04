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
      if asset.blank?
        "None Assigned"
      elsif asset_id?
        asset.code_asset
      else 
        "None Assigned"
      end
    end
  
    def location_details 
      if location.blank?
        "Not Registered"
      elsif losslocation_id?
        location.location_list
      else 
        "Location has been removed"
      end
    end
  
    def last_staff_to_handle
       if laststaff.blank?
          "Not Registered"
        elsif lossstafflast_id?
          laststaff.staff_name_with_position
        else 
          "Location has been removed"
        end
    end
  
    def hod_details 
      if hod.blank?
         "Not Registered"
       elsif hod_id?
         hod.staff_name_with_position
       else 
       end
    
        suid = hod_id.to_a
        exists = Staff.find(:all, :select => "id").map(&:id)
        checker = suid & exists     

        if hod_id == nil
           "" 
         elsif checker == []
           "Staff No Longer Exists" 
        else
          hod.staff_name_with_position
        end
   end
   
   def officer_details 
         suid = sio_id.to_a
         exists = Staff.find(:all, :select => "id").map(&:id)
         checker = suid & exists     

         if sio_id == nil
            "" 
          elsif checker == []
            "Staff No Longer Exists" 
         else
           officer.staff_name_with_position
         end
    end
end
