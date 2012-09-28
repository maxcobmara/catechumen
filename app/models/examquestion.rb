class Examquestion < ActiveRecord::Base

  belongs_to :creator,  :class_name => 'Staff', :foreign_key => 'creator_id'
  belongs_to :approver, :class_name => 'Staff', :foreign_key => 'approver_id'
  belongs_to :editor,   :class_name => 'Staff', :foreign_key => 'editor_id'
  belongs_to :subject
  belongs_to :programme
  belongs_to :topic
  has_and_belongs_to_many :exams
  
  has_attached_file :diagram,
                    :url => "/assets/examquestions/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/examquestions/:id/:style/:basename.:extension"
                    
                    #may require validation
                    
  validates_presence_of :questiontype, :question, :answer, :marks, :qstatus
  
  
  #has_many :examsubquestions, :dependent => :destroy
  #accepts_nested_attributes_for :examsubquestions, :reject_if => lambda { |a| a[:question].blank? }
  
  #has_many :exammcqanswers, :dependent => :destroy
  #accepts_nested_attributes_for :exammcqanswers, :reject_if => lambda { |a| a[:answer].blank? }
  
  
  
  def status_workflow
    flow = Array.new
        if qstatus == nil || qstatus == "New"
          flow << "New" << "Submit"
        elsif qstatus == "Submit" || qstatus == "Editing"
          flow << "Editing" << "Ready For Approval" 
        elsif qstatus == "Re-Edit"
          flow << "Re-Edit"  << "For Approval"
        elsif qstatus == "Ready For Approval" || qstatus == "For Approval"
          flow << "Re-Edit" << "Approved" << "Rejected"
        elsif qstatus == "Approved"
           flow << "Approved"
        else
        end
    flow
  end
  
  def question_editor
    sibpos = creator.position.parent.sibling_ids
    sibs   = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", sibpos]).map(&:staff_id)
    applicant = Array(creator_id)
    sibs - applicant
  end
  
  
  def self.search2(search2)
     if search2 
       if search2 != '0'
         @examquestions = Examquestion.find(:all, :conditions => ["programme_id=?", search2 ])
       else
         @examquestions = Examquestion.find(:all)
       end
     else
       @examquestions = Examquestion.find(:all)
     end
  end
  
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
     (Examquestion::QLEVEL.find_all{|disp, value| value == difficulty }).map {|disp, value| disp}
   end
   
   QTYPE = [
          #  Displayed       stored in db
          [ "Objektif - MCQ", "MCQ" ],
          [ "Subjektif - MEQ","MEQ" ],
          [ "Subjektif - SEQ","SEQ" ],
          [ "ACQ",            "ACQ" ],
          [ "OSCI",           "OSCI" ],
          [ "OSCII",          "OSCII" ]
          
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
             [ "(R) Easy | Mudah","1" ],
             [ "(S) Intermediate | Pertengahan","2" ],
             [ "(T) Difficult | Sukar", "3" ]
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
   
  def subject_details
     if subject.blank? 
       "None Assigned"
     else 
       subject.subject_code_with_subject_name
     end
  end
     
   
  def creator_details 
    if creator.blank? 
       "None Assigned"
     else 
       creator.name #mykad_with_staff_name
     end
  end
      
  def editor_details         
    if editor.blank?
      "None Assigned"
    elsif editor_id?
      editor.mykad_with_staff_name
    else 
      "None Assigned"
    end
  end
  
  def approver_details
    if approver.blank? 
      "None Assigned"
    else 
      approver.name
    end
  end
        

   
  
end
