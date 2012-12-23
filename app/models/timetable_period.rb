class TimetablePeriod < ActiveRecord::Base
  belongs_to :timetable
  
  DAY_CHOICE = [
       #  Displayed       stored in db
       [ "Mon-Thur",  1 ],
       [ "Friday",    2 ]
  ]
end
