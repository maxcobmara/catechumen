class Sdicipline < ActiveRecord::Base
  belongs_to :staff
  belongs_to :cofile
  #belongs_to :reportingstaff,  :class_name => 'Staff',   :foreign_key => 'reportedby_id'
  belongs_to :studentwithcase, :class_name => 'Student', :foreign_key => 'student_id'
  belongs_to :file,       :class_name => 'Cofile', :foreign_key => 'cofile_id'
  #belongs_to :staff,   :foreign_key => 'reportedby_id'
  belongs_to :student, :foreign_key => 'student_id'
  belongs_to :staff, :foreign_key => 'reportedby_id'
  
  validates_presence_of :reportedby_id, :student_id
   
    def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
    
    def self.find_main
        Student.find(:all, :condition => ['student_id IS NULL'])
    end
      
    def self.find_main
            Cofile.find(:all, :condition => ['cofile_id IS NULL'])
    end
    
    #-----------------------------------------------
   STATUS = [
         #  Displayed       stored in db
         [ "No Case","No Case" ],
         [ "Open","Open" ],
         [ "Closed", "Closed" ],
         [ "Refer to BPL", "Refer to BPL" ]
    ]
end
