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
  INFRACTION = [
         #  Displayed       stored in db
         [ "Merokok", 1  ],
         [ "Ponteng Kelas", 2 ],
         [ "Bergaduh", 3 ],
         [ "Lain Lain", 4 ]
      ]
    
    
   STATUS = [
         #  Displayed       stored in db
         [ "No Case","No Case" ],
         [ "New","New" ],
         [ "Open","Open" ],
         [ "Closed", "Closed" ],
         [ "Refer to BPL", "Refer to BPL" ]
    ]
    
    def reporter_details 
          suid = reportedby_id.to_a
          exists = Staff.find(:all, :select => "id").map(&:id)
          checker = suid & exists     

          if reportedby_id == nil
             "" 
           elsif checker == []
             "Staff No Longer Exists" 
          else
            staff.mykad_with_staff_name
          end
    end
    
end
