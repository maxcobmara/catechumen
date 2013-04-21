class TimetablePeriod < ActiveRecord::Base
  belongs_to :timetable
  
  DAY_CHOICE = [
       #  Displayed       stored in db
       [ "Mon-Thur",  1 ],
       [ "Friday",    2 ]
  ]
<<<<<<< HEAD
=======
  
  def timing
    "#{start_at.strftime("%l:%M %p")}"+" -"+"#{end_at.strftime("%l:%M %p")}"
  end 
  
>>>>>>> 0da980ec7c2c95feb7bdc68cdebc6187e0fe20f4
end
