class Bankaccount < ActiveRecord::Base
  belongs_to :staff
  belongs_to :bank



   BANKTYPE = [
         #  Displayed       stored in db
         [ "Simpanan",1 ],
         [ "Simpanan Bersama",2 ],
         [ "Semasa",3 ],
         [ "Simpanan Tetap",4 ],
   ]
  
end
