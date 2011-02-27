class Score < ActiveRecord::Base

before_save :save_my_vars  

belongs_to :grade
validates_presence_of :description

def save_my_vars
  self.score	= type_marks
end 
def type_marks
  (marks * weightage)/100
end
  
E_TYPES = [
    #  Displayed       stored in db
      [ "Clinical Work",1 ],
      [ "Assignment",2 ],
      [ "Project", 3 ],
      [ "Clinical Report", 4 ],
      [ "Test", 5 ],
      [ "Exam", 6 ],
      

]
end
