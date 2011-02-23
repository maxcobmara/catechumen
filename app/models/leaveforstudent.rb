class Leaveforstudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :staff
  belongs_to :programme

#<<<<<<< HEAD
validates_presence_of :student_id, :leavetype
validates_numericality_of :telno
#=======
  #validates_presence_of :student_id, :leavetype
  #validates_numericality_of :telno
  
#>>>>>>> 3fe0965cad3574e259d7a5335148679a381ed41b
  
  def self.find_main
    Student.find(:all, :condition => ['student_id IS NULL'])
  end
  
  def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def self.find_main
    Programme.find(:all, :condition => ['programme_id IS NULL'])
  end
  
 
 STUDENTLEAVETYPE = [
        #  Displayed       stored in db
        [ "Weekend Day","Weekend Day" ],
        [ "Weekend Overnight","Weekend Overnight" ],
        [ "Emergency","Emergency" ]
  ]
end
