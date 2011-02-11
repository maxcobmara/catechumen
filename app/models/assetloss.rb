class Assetloss < ActiveRecord::Base
  #belongs_to :asset 
  belongs_to :part, :foreign_key => 'part_id' 
  belongs_to :residence, :foreign_key => 'residence_id'
  belongs_to :staff, :foreign_key => 'staff_id' 
  
  belongs_to :asslost, :class_name => 'Asset', :foreign_key => 'asset_id'
  
  #Residence
  belongs_to :assetlocation,  :class_name => 'Residence', :foreign_key => 'losslocation_id'
  
  #Staff
  belongs_to :laststaff,        :class_name => 'Staff', :foreign_key => 'lossstafflast_id' 
  belongs_to :hod,              :class_name => 'Staff', :foreign_key => 'hod_id'
  belongs_to :enforce,         :class_name => 'Staff', :foreign_key => 'newrule_id'
  belongs_to :officer,         :class_name => 'Staff', :foreign_key => 'sio_id'
  
  validates_presence_of :reportcode, :losstype, :sio_id
  
   def self.find_main
     Asset.find(:all, :condition => ['asset_id IS NULL'])
   end
   
   def self.find_main
      Part.find(:all, :condition => ['part_id IS NULL'])
    end
    
    def self.find_main
        Residence.find(:all, :condition => ['residence_id IS NULL'])
      end
    
    def self.find_main
        Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
  
  LOSS = [
        #  Displayed       stored in db
        [ "Cash","Cash" ],
        [ "Asset","AB" ],
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
end
