class Examquestion < ActiveRecord::Base

  belongs_to :creator,  :class_name => 'Staff', :foreign_key => 'creator_id'
  belongs_to :approver, :class_name => 'Staff', :foreign_key => 'approver_id'
  belongs_to :editor,   :class_name => 'Staff', :foreign_key => 'editor_id'
  belongs_to :subject,  :class_name => 'Programme', :foreign_key => 'subject_id'
  #belongs_to :programme
  belongs_to :topic,    :class_name => 'Programme', :foreign_key => 'topic_id'
  has_and_belongs_to_many :exams
  
  has_many :answerchoices, :dependent => :destroy
  accepts_nested_attributes_for :answerchoices, :allow_destroy => true , :reject_if => lambda { |a| a[:description].blank? }
  has_many :examanswers, :dependent => :destroy
  accepts_nested_attributes_for :examanswers, :allow_destroy => true , :reject_if => lambda { |a| a[:answer_desc].blank? }
  has_many :shortessays, :dependent => :destroy
  accepts_nested_attributes_for :shortessays#, :allow_destroy => true , :reject_if => lambda { |a| a[:subquestion].blank? }
  has_many :booleanchoices, :dependent => :destroy
  accepts_nested_attributes_for :booleanchoices, :allow_destroy => true , :reject_if => lambda { |a| a[:description].blank? }
  has_many :booleananswers, :dependent => :destroy
  accepts_nested_attributes_for :booleananswers, :allow_destroy => true , :reject_if => lambda { |a| a[:answer].blank? }
  
  attr_accessor :activate, :answermcq
  
  named_scope :mcqq,  :conditions => {:questiontype => 'MCQ'}     # 27 June 2012
  named_scope :meqq, :conditions => {:questiontype => 'MEQ'}      # 27 June 2012
  named_scope :seqq, :conditions => {:questiontype => 'SEQ'} 	  # 22 July 2012
  named_scope :acqq, :conditions => {:questiontype => 'ACQ'}
  named_scope :osci2q, :conditions => {:questiontype => 'OSCI'}
  named_scope :osci3q, :conditions => {:questiontype => 'OSCII'}
  named_scope :osceq, :conditions => {:questiontype =>'OSCE'}
  named_scope :ospeq, :conditions =>  {:questiontype =>'OSPE'}
  named_scope :vivaq, :conditions =>  {:questiontype =>'VIVA'}
  named_scope :truefalseq, :conditions =>  {:questiontype =>'TRUEFALSE'}
  
  has_attached_file :diagram,
                    :url => "/assets/examquestions/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/examquestions/:id/:style/:basename.:extension"
                    
                    #may require validation
                    
  validates_presence_of :subject_id, :topic_id, :questiontype, :question, :marks, :qstatus #17Apr2013,:answer #9Apr2013-compulsory for subject_id
  
  
  #has_many :examsubquestions, :dependent => :destroy
  #accepts_nested_attributes_for :examsubquestions, :reject_if => lambda { |a| a[:question].blank? }
  
  #has_many :exammcqanswers, :dependent => :destroy
  #accepts_nested_attributes_for :exammcqanswers, :reject_if => lambda { |a| a[:answer].blank? }
  
  attr_accessor :programme_id #9Apr2013 - rely on subject (root of subject[programme])
  #attr_accessor :question1,:question2,:question3,:question4,:questiona,:questionb,:questionc,:questiond
  
  before_save :set_nil_if_not_activate, :set_subquestions_if_seq, :set_answer_for_mcq
  
  def set_nil_if_not_activate
      if self.id != nil   
          if questiontype=="MCQ" && activate != "1" 
              self.answerchoices[0].description = "" if self.answerchoices[0]#.id !=nil
              self.answerchoices[1].description = "" if self.answerchoices[1]#.id !=nil
              self.answerchoices[2].description = "" if self.answerchoices[2]#.id !=nil
              self.answerchoices[3].description = "" if self.answerchoices[3]#.id !=nil
          end
      end
  end
  
  def set_answer_for_mcq
      if answermcq !=nil
        self.answer=answermcq.to_s
      end
  end
  
  def set_subquestions_if_seq   
    if self.id == nil && questiontype=="SEQ" 
        self.shortessays[0].item = "a"    #new 
        self.shortessays[1].item = "b" 
        self.shortessays[2].item = "c"
    end
  end
  
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
    programme = User.current_user.staff.position.unit
    editors = Position.find(:all,:conditions => ['unit=?',programme]).map(&:staff_id).compact
    editors
  end
  
  def question_approver #to assign question -> KP
    ###latest finding - as of Mei-Jul/Aug 2013 - approver should be at Ketua Program level ONLY (own programme @ other programme)### 
    
    role_kp = Role.find_by_name('Programme Manager')  #must have role as Programme Manager
    staff_with_kprole = User.find(:all, :joins=>:roles, :conditions=>['role_id=?',role_kp]).map(&:staff_id).compact.uniq
    programme_name = Programme.roots.map(&:name)    #must be among Academic Staff 
    approver = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?) AND staff_id IN(?)', programme_name, staff_with_kprole])
    approver   
  end
  
  
  def self.search2(search2)
    common_subject = Programme.find(:all, :conditions=>['course_type=?','Commonsubject']).map(&:id)
    if search2 
      if search2 == '0'
        @examquestions = Examquestion.find(:all)
      elsif search2 == '1'
        @examquestions = Examquestion.find(:all, :conditions => ["subject_id IN (?)", common_subject])
      else
        subject_of_program = Programme.find(search2).descendants.at_depth(2).map(&:id)
        @examquestions = Examquestion.find(:all, :conditions => ["subject_id IN (?) and subject_id NOT IN (?)", subject_of_program, common_subject])
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
          [ "OSCII",          "OSCII" ],
          [ "OSCE",           "OSCE"],  #10Apr2013-newly added - to confirm
          [ "OSPE",           "OSPE"],  #10Apr2013-newly added - to confirm
          [ "VIVA",           "VIVA"],   #10Apr2013-newly added - to confirm
          [ "Objektif - True/False",  "TRUEFALSE"]   #10Apr2013-newly added - to confirm
          
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
       subject.subject_list
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
     
  #10Apr2013      
  def usage_frequency
      Examquestion.find(:all, :joins=>:exams,:conditions=>['examquestion_id=?',id]).count
  end
  #10Apr2013 
  
  def combine_subquestions
    shortessays2=Shortessay.find(:all, :conditions=>['examquestion_id=?',id])
    subq=[]
    shortessays2.each do |y|
      unless y.subquestion.nil? || y.subquestion.blank?
        subq<<"("+y.item.to_s+") "+y.subquestion+" ("+y.submark.to_s+") ["+y.subanswer.to_s+"]"
      end
    end
    subq.to_s
  end
  
  #to do LATER - DOWNLOAD EXCEL - BPL reserve onwards
  def self.header_excel
    ["Programme","Subject","Question Type","Question","Answer","SEQ-Question(Marks)[Answer]","Marks","Category","Keyword","Status","Creator","Creation Date","Difficulty","Status Remark","Editor","Editing Date","Approver","Approval Date"]
  end
 
  def self.column_excel
    [{:subject=>:programme_coursetype_name},{:subject=>:subject_list},:questiontype,:question,:answer,:combine_subquestions,:marks,:category,:qkeyword,:qstatus,{:creator=>:name},:createdt,:render_difficulty,:statusremark,{:editor=>:name},:editdt,{:approver=>:name},:approvedt]
  end
end
