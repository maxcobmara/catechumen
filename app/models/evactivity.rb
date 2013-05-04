class Evactivity < ActiveRecord::Base
  belongs_to :appraisal
  validates_presence_of :evactivity
 
 def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
 end
 
 EVACT = [
          #  Displayed       stored in db
          [ "Komuniti","1" ],
          [ "Jabatan","2" ],
          [ "Daerah", "3" ],
          [ "Negeri", "4" ],
          [ "Negera", "5" ],
          [ "Antarabangsa", "9" ]
   ]
  
  
end
