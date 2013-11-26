class TimetablePeriod < ActiveRecord::Base
  belongs_to :timetable
  
  DAY_CHOICE = [
       #  Displayed       stored in db
       [ "Mon-Thur",  1 ],
       [ "Friday",    2 ]
  ]
  
  def timing
    "#{start_at.strftime("%l:%M %p")}"+" -"+"#{end_at.strftime("%l:%M %p")}"
  end 
  
end
