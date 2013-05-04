class Sdicipline < ActiveRecord::Base
  belongs_to :staff
  belongs_to :cofile
  #belongs_to :reportingstaff,  :class_name => 'Staff',   :foreign_key => 'reportedby_id'
  belongs_to :studentwithcase, :class_name => 'Student', :foreign_key => 'student_id'
  belongs_to :file,       :class_name => 'Cofile', :foreign_key => 'cofile_id'
  #belongs_to :staff,   :foreign_key => 'reportedby_id'
  belongs_to :student, :foreign_key => 'student_id'
  belongs_to :staff, :foreign_key => 'reportedby_id'
  belongs_to :warden, :class_name=> 'Staff', :foreign_key => 'warden_id'
  belongs_to :mentorname, :class_name=> 'Mentee', :foreign_key => 'mentor_id'
  belongs_to :counsellor, :class_name=> 'Position', :foreign_key => 'caunsellor_id'
  has_many :commandant, :class_name => 'Position', :foreign_key => 'commandant_id'
  
  validates_presence_of :reportedby_id, :student_id, :status
   
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
         [ "Refer to Mentor", "Refer to Mentor" ],
         [ "Refer to Counsellor", "Refer to Counsellor" ],
         [ "Refer to Komandan", "Refer to Komandan" ],#-8/12/2011 - Shaliza changed for student status as user requested.-->
         [ "Others","Others" ]
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
            staff.staff_name_with_title
          end
    end
    
    def student_name
      suid = student_id.to_a
      suexists = Student.find(:all, :select => "id").map(&:id)
      studentchecker = suid & suexists

        if student_id == nil
          ""
        elsif studentchecker == []
          "Student No Longer Exists"
        else
          " #{student.formatted_mykad_and_student_name}"   
        end 
    end
    
    def file_name
      suid = cofile_id.to_a
      suexists = Cofile.find(:all, :select => "id").map(&:id)
      filechecker = suid & suexists

        if cofile_id == nil
          ""
        elsif filechecker == []
          "File No Longer Exists"
        else
          " #{file.name}"   
        end 
    end
    
    def counsellor_details 
      suid = caunsellor_id.to_a
      exists = Position.find(:all, :select => "id").map(&:id)
      checker = suid & exists     

      if caunsellor_id == nil
      "" 
      elsif checker == []
      "Staff No Longer Exists" 
      else
            counsellor.title_details
      end
    end
    
    def warden_name
      suid = warden_id.to_a
      suexists = Staff.find(:all, :select => "id").map(&:id)
      studentchecker = suid & suexists

        if warden_id == nil
          ""
        elsif studentchecker == []
          "Staff No Longer Exists"
        else
          warden.staff_name_with_title   
        end 
    end
    
    def room_no
      suid = student_id.to_a
      suexists = Tenant.find(:all, :select => "student_id").map(&:student_id)
      roomchecker = suid & suexists
      curroom = Tenant.find(:all, :select => "location_id", :conditions => {:student_id => roomchecker}, :limit => 1).map(&:location_id)
      romname = Location.find(:all, :conditions => {:id => curroom}).map(&:name)
      romcode = Location.find(:all, :conditions => {:id => curroom}).map(&:code)
      

        if student_id == nil
          ""
        elsif roomchecker == []
          "Not Assigned"
        else
          romcode.to_s + " - " + romname.to_s
        end 
    end
    
end
