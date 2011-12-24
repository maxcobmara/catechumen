class Trainingreport < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :staff
  belongs_to :tpa, :class_name => 'Staff', :foreign_key => 'tpa_id'
  
  
  CTYPE = [
        #  Displayed       stored in db
        [ "Kuliah",1 ],
        [ "Tutorial",2 ],
        [ "Amali",3 ]
  ]
end
