class Spmresult < ActiveRecord::Base
  belongs_to :student
 # 06/10/2011 - Shaliza Update to display grade such as 1A,2A,3B and so on as user requested -->
  GRADE = [
          #  Displayed       stored in db
          [ "1A",1 ],
          [ "2A",2 ],
          [ "3B",3 ],
          [ "4B",4 ],
          [ "5C",5 ],
          [ "6C",6 ],
          [ "7D",7 ],
          [ "8E",8 ],
          [ "9G",9 ]
  ]
end
