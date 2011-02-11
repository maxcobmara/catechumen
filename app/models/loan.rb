class Loan < ActiveRecord::Base
  belongs_to :staff
 # validates_presence_of :ltype
#  validates_numericality_of :accno
  
  
  LTYPE = [
           #  Displayed       stored in db
           [ "Perumahan", 1 ],
           [ "Kenderaan", 2 ],
           [ "Komputer", 3 ],
           [ "Other", 4 ],
           [ "None", 99 ]
  ]
end
