class Kin < ActiveRecord::Base
  belongs_to :staff
  belongs_to :student
  
  KTYPE = [
          #  Displayed       stored in db
          [ "Isteri",1 ],
          [ "Suami",2 ],
          [ "Ibu", 3 ],
          [ "Bapa", 4 ],
          [ "Anak", 5 ],
          [ "Nenek", 9 ],
          [ "Saudara Kandung", 11 ],
          [ "Penjaga", 12 ],
          [ "Bekas Isteri", 13 ],
          [ "Bekas Suami", 14 ],
          [ "Penjamin", 99 ]
   ]
end
