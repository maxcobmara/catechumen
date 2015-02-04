class TimetablePeriod < ActiveRecord::Base
  belongs_to :timetable
  
  DAY_CHOICE = [
       #  Displayed       stored in db
       [ I18n.t(:'date.abbr_day_names')[0]+"-"+I18n.t(:'date.abbr_day_names')[3] ,  1 ],
       [ I18n.t(:'date.abbr_day_names')[4],    2 ]
  ]

  #[ "Mon-Thur",  1 ],
  #[ "Friday",    2 ]

  def timing
    "#{I18n.l(start_at, :format => "%l:%M %P")}"+" -"+"#{I18n.l(end_at, :format => "%l:%M %P")}"
  end 
  
end
