class Leaveforstudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :staff

  validates_presence_of :student_id, :leavetype
  validates_numericality_of :telno
  
  
  def self.find_main
    Student.find(:all, :condition => ['student_id IS NULL'])
  end
  
  def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
 
 STUDENTLEAVETYPE = [
        #  Displayed       stored in db
        [ "Weekend Day","Weekend Day" ],
        [ "Weekend Overnight","Weekend Overnight" ],
        [ "Emergency","Emergency" ]
  ]
end
