class Examquestion < ActiveRecord::Base
 # belongs_to :subject, :foreign_key => 'curriculum_id'
  #belongs_to :staff, :foreign_key => 'staff_id' 
  belongs_to :creator,       :class_name => 'Staff', :foreign_key => 'creator_id'
  belongs_to :approver,       :class_name => 'Staff', :foreign_key => 'approver_id'
  belongs_to :editor,       :class_name => 'Staff', :foreign_key => 'editor_id'
  belongs_to :subject,       :class_name => 'Subject', :foreign_key => 'curriculum_id'
  #belongs_to :staff
  
  validates_presence_of :curriculum_id, :questiontype, :question, :answer, :marks, :qstatus
  
  #def self.find_main
  #    Examquestion.find(:all, :condition => ['staff_id IS NULL'])
 # end
  
   def self.find_main
     Subject.find(:all, :condition => ['subject_id IS NULL'])
   end
   
   def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
   end
   
   
   
   def render_difficulty
     (Examquestion::QLEVEL.find_all{|disp, value| value == status }).map {|disp, value| disp}
   end
   
   QTYPE = [
          #  Displayed       stored in db
          [ "SEQ","SEQ" ],
          [ "MCQ","MCQ" ],
          [ "ACQ", "ACQ" ],
          [ "OSCI", "OSCI" ],
          [ "OSCII", "OSCII" ],
          [ "MEQ", "MEQ" ]
          
   ]
   
   QCATEGORY = [
           #  Displayed       stored in db
           [ "Recall","Recall" ],
           [ "Comprehension","Comprehension" ],
           [ "Application", "Application" ],
           [ "Analysis", "Analysis" ],
           [ "Synthesis", "Synthesis" ]
    ]
    
    QLEVEL = [
             #  Displayed       stored in db
             [ "Easy | Mudah","1" ],
             [ "Intermediate | Pertengahan","2" ],
             [ "Difficult | Sukar", "3" ]
    ]
  




    QSTATUS = [
        #  Displayed       stored in db
        [ "Created","Created" ],
        [ "Submitted","Submitted" ],
        [ "Edited", "Edited" ],
        [ "Approved", "Approved" ],
        [ "Reject at College", "Reject at College" ],
        [ "Sent to KMM", "Sent to KMM" ],
        [ "Re-Edit", "Re-Edit" ],
        [ "Rejected", "Rejected" ]
   ]
  
end
