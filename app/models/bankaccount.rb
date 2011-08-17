class Bankaccount < ActiveRecord::Base
  
  belongs_to :staff
  
  
  BANK = [
        #  Displayed       stored in db
        [ "Affin Bank Berhad", 1 ],
        [ "Alliance Bank Berhad", 2  ],
        [ "AmBank Berhad", 3 ],
        [ "CIMB Bank Berhad", 4 ],
        [ "EON Bank Berhad", 5 ],
        [ "Hong Leong Bank Berhad", 6 ],
        [ "Maybank", 7 ],
        [ "Public Bank Berhad", 8 ],
        [ "RHB Bank Berhad", 9 ],
        [ "Bank Simpanan Nasional", 10 ]
  ]
  
  BANKTYPE = [
        #  Displayed       stored in db
        [ "Simpanan",1 ],
        [ "Simpanan Bersama",2 ],
        [ "Semasa",3 ],
        [ "Simpanan Tetap",4 ],
  ]
  
end
