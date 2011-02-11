class Kin < ActiveRecord::Base
  belongs_to :staff
  belongs_to :student
 # validates_presence_of :kintype_id, :name
 # validates_numericality_of :phone
  
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
          [ "Bekas Suami", 14 ]
   ]
end
