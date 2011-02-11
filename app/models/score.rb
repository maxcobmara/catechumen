class Score < ActiveRecord::Base
  
belongs_to :grade
validates_presence_of :description
  
TYPES = [
    #  Displayed       stored in db
      [ "Clinical Work","1" ],
      [ "Assignment","2" ],
      [ "Project", "3" ],
      [ "Clinical Report", "4" ],
      [ "Test", "5" ],
      [ "Exam", "6" ],
      

]
end
