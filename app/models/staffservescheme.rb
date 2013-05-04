class Staffservescheme < ActiveRecord::Base
  
  has_many :staffclassifications
  has_many :staffgrades, :through => :staffclassifications
  
  validates_uniqueness_of :name
  
  GROUP = [
       #  Displayed       stored in db
       [ "Pengurusan & Professional"    , "P" ],
       [ "Sokongan I"  , "S1" ],
       [ "Sokongan II" , "S2" ],
       [ "Bersepadu" , "B" ]
  ]
end
