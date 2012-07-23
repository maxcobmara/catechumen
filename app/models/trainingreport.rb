class Trainingreport < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :creator,  :class_name => 'Staff',  :foreign_key => 'staff_id'
  belongs_to :tpa,      :class_name => 'Staff',   :foreign_key => 'tpa_id'
  
  validates_presence_of :classtype, :location_state, :ls_comment
  
  CTYPE = [
        #  Displayed       stored in db
        [ "Kuliah",1 ],
        [ "Tutorial",2 ],
        [ "Amali",3 ]
  ]
end
