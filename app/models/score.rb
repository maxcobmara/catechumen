class Score < ActiveRecord::Base

before_save :save_my_vars  

belongs_to :grade
#validates_presence_of :description

def save_my_vars
  self.score	= type_marks
  self.marks
end 

def type_marks
  (marks * weightage)/100
end

  


E_TYPES = [
    #  Displayed       stored in db
      [ "Assignment",1 ],
      [ "Project", 2 ],
      [ "Practical Test",3 ],
      [ "Test",4 ],
      [ "Exam", 5],
      

]

end
