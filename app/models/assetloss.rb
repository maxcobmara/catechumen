class Assetloss < ActiveRecord::Base
  belongs_to :part, :foreign_key => 'part_id' 
  belongs_to :location
  belongs_to :staff, :foreign_key => 'staff_id' 
  belongs_to :asset
  
  #Residence
  belongs_to :assetlocation,  :class_name => 'Location', :foreign_key => 'losslocation_id'
  
  #Staff
  belongs_to :laststaff,        :class_name => 'Staff', :foreign_key => 'lossstafflast_id' 
  belongs_to :hod,              :class_name => 'Staff', :foreign_key => 'hod_id'
  belongs_to :enforce,          :class_name => 'Staff', :foreign_key => 'newrule_id'
  belongs_to :officer,          :class_name => 'Staff', :foreign_key => 'sio_id'
  
  validates_presence_of :reportcode, :losstype, :sio_id
  
  
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
  
  
  def asset_details
    if asset.any?
      asset.code_asset
    else
    end
  end
  
  
  def location_details 
       suid = losslocation_id.to_a
       exists = Location.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if losslocation_id == nil
          "" 
        elsif checker == []
          "Location No Longer Exists" 
       else
         assetlocation.name
       end
  end
  
  def hod_details 
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
