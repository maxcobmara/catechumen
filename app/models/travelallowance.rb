class Travelallowance < ActiveRecord::Base
  belongs_to :travelclaim
 # before_save :varmyass
 
 def meal
   no_of_day * allowance_per_day
 end 
 
 def mealss
    no_of_day * allowance_per_day
 end
 
 def daily
     no_of_day * allowance_per_day
 end
 
 def lodging
      no_of_day * allowance_per_day
 end
 
 def hotel
       no_of_day * allowance_per_day
 end
 

 
  

  
 
  
  ALLOWANCETYPE = [
         #  Displayed       stored in db
         [ "Elaun Makan",1 ],
         [ "Elaun Makan (S/S)",2 ],
         [ "Elaun Harian",3 ],
         [ "Elaun Lodging",4 ],
         [ "Sewa Hotel",5 ],
         [ "Cukai Kerajaan",6 ]
        
   ]
   
 
end
