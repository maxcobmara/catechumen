class TimetablePeriod < ActiveRecord::Base
  belongs_to :timetable
 
  validates_uniqueness_of :sequence, :scope => :timetable_id
  
  DAY_CHOICE = [
       #  Displayed       stored in db
       [ "Sun-Wed / Mon-Thurs" ,  1 ],
       [ "Thurs / Fri",    2 ]
  ]

  def timing
    "#{I18n.l(start_at, :format => "%l:%M %P")}"+" -"+"#{I18n.l(end_at, :format => "%l:%M %P")}"
  end 
  
end
