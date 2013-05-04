class Counselling < ActiveRecord::Base
  belongs_to :student
  belongs_to :cofile, :foreign_key => 'cofile_id'
 
def self.find_main
     Student.find(:all, :condition => ['student_id IS NULL'])
end
 #----------------------------------- code for repeating field session------------------------------------- 
   
   has_many :scsessions, :dependent => :destroy
   accepts_nested_attributes_for :scsessions, :reject_if => lambda { |a| a[:issue].blank? }
#------------------------------------------------------------------------------------------------------------
# 07/11/2011 - Shaliza fixed for student and file no longer exist.
def student_details 
    suid = student_id.to_a
    exists = Student.find(:all, :select => "id").map(&:id)
    checker = suid & exists     

    if student_id == nil
      "" 
    elsif checker == []
     "Student No Longer Exists" 
    else
      student.name.upcase
    end
end

def file_details 
    suid = cofile_id.to_a
    exists = Cofile.find(:all, :select => "id").map(&:id)
    checker = suid & exists     

    if cofile_id == nil
      "" 
    elsif checker == []
     "-" 
    else
      cofile.file_no_and_name
    end
end
    

end
