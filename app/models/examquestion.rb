class Examquestion < ActiveRecord::Base
 
  belongs_to :creator,       :class_name => 'Staff', :foreign_key => 'creator_id'
  belongs_to :approverqc,       :class_name => 'Position', :foreign_key => 'approver_id'
  belongs_to :editor,       :class_name => 'Position', :foreign_key => 'editor_id'
  belongs_to :subject,       :class_name => 'Subject', :foreign_key => 'curriculum_id'
  belongs_to :topic

  has_and_belongs_to_many :exammakers
  
  validates_presence_of :curriculum_id, :questiontype, :question, :answer, :marks, :qstatus
  
  has_attached_file :diagram,
                    :url => "/assets/examquestions/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/examquestions/:id/:style/:basename.:extension"
                    
  has_many :examsubquestions, :dependent => :destroy
  accepts_nested_attributes_for :examsubquestions, :reject_if => lambda { |a| a[:question].blank? }
  
  has_many :exammcqanswers, :dependent => :destroy
  accepts_nested_attributes_for :exammcqanswers, :reject_if => lambda { |a| a[:answer].blank? }
  
   def self.find_main
     Subject.find(:all, :condition => ['subject_id IS NULL'])
   end
   
   def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
   end
   
   def render_difficulty
     (Examquestion::QLEVEL.find_all{|disp, value| value == difficulty }).map {|disp, value| disp}
   end
   
   named_scope :obj,      :conditions => { :questiontype => "OBJ"}
   named_scope :mcq,      :conditions => { :questiontype => "MCQ"}
   named_scope :blank,    :conditions => { :questiontype => "blank"}
   named_scope :tf,       :conditions => { :questiontype => "TF" }
   named_scope :match,    :conditions => { :questiontype => "MATCH"}
   named_scope :essay,    :conditions => { :questiontype =>"ESSAY"}

   FILTERS = [
      {:scope => "all",       :label => "All"},
      {:scope => "obj",       :label => "Objective"},
      {:scope => "mcq",       :label => "Multiple Choice"},
      {:scope => "blank",     :label => "Fill In The Blank"},
  	  {:scope => "tf",        :label => "True/False"},
  	  {:scope => "match",     :label => "Match"},
  	  {:scope => "essay",     :label => "Short Essay"},

      ]
   
   QTYPE = [
          #  Displayed       stored in db
          [ "Objective","OBJ" ],
          [ "Multiple-Choice", "MCQ" ],
          [ "Fill In The Blank", "BLANK" ],
          [ "True/False","TF" ],
          [ "Match", "MATCH" ],
          [ "Short Essay", "ESSAY" ]
        
          
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
        [ "Reject at PL", "Reject at PL" ],
        [ "Sent to KM", "Sent to KMM" ],
        [ "Re-Edit", "Re-Edit" ],
        [ "Rejected", "Rejected" ]
   ]
   
   def subject_details 
         suid = curriculum_id.to_a
         exists = Subject.find(:all, :select => "id").map(&:id)
         checker = suid & exists     

         if curriculum_id == nil
            "" 
          elsif checker == []
            "Subject No Longer Exists" 
         else
           subject.subject_code_with_subject_name
         end
    end
   
     def creator_details 
           suid = creator_id.to_a
           exists = Staff.find(:all, :select => "id").map(&:id)
           checker = suid & exists     

           if creator_id == nil
              "" 
            elsif checker == []
              "Staff No Longer Exists" 
           else
             creator.staff_name_with_title
           end
      end
      
       
        
        def approver_details 
               suid = approver_id.to_a
               exists = Position.find(:all, :select => "id").map(&:id)
               checker = suid & exists     

               if approver_id == nil
                  "" 
                elsif checker == []
                  "Staff No Longer Exists" 
               else
                 approverqc.unit_staff_name
               end
          end
          
          
#-----------------------Search By Subject--------------------------------------
   def self.search(search)
      if search 
        if search != '0'
          @examquestions = Examquestion.find(:all, :conditions => ["curriculum_id=?", search ])
        else
          @examquestions = Examquestion.find(:all)
        end
      else
        @examquestions = Examquestion.find(:all)
      end
   end
    
  
end
