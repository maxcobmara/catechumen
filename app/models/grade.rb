class Grade < ActiveRecord::Base
  
  validates_presence_of   :student_id, :subject_id
  validates_uniqueness_of :subject_id, :scope => :student_id, :message => " - This student has already taken this subject"
  
  belongs_to :studentgrade, :class_name => 'Student', :foreign_key => 'student_id'  #Link to Model student
  belongs_to :subjectgrade, :class_name => 'Programme', :foreign_key => 'subject_id'  #Link to Model subject

  has_many :scores, :dependent => :destroy
  accepts_nested_attributes_for :scores, :reject_if => lambda { |a| a[:description].blank? }
  
  attr_accessor :programme_id, :final_exam_paper, :intake_id, :summative_weightage, :formative_scores_var,:summative_weightage2,:summative_weightage3,:summative_weightage4,:summative_weightage5,:summative_weightage6
    
    # 22 May 2012
    ## CA + MSE (excel file) = (total_formative * (100 - examweight)/100)
    # sample : 19.34 = 64.47 x (100 - 70)/100   (note: examweight => summative weightage) [assumption-only 1 item of score for final/summative]
    
    def ca_plus_mse
      total_formative * (100 - examweight)/100
    end
    #-------10Apr2013
    
    def total_per
      Score.sum(:weightage, :conditions => ["grade_id = ?", id])
    end
    
    def total_formative
      Score.sum(:score, :conditions => ["grade_id = ?", id])
    end
    
    def total_summative
      if exam1marks == 0
        0
      else
        (exam1marks * examweight)/100
      end
    end
    
    def finale
      ((exam1marks * examweight)/100) + ((total_formative * (100 - examweight)/100))
    end
    
    def grade_it
      if finale < 40
        "F"
      elsif finale < 50
        "D"
      elsif finale < 75
        "C"
      elsif finale < 90
        "B"
      else
        "A"
      end
        
    end
    
   
   def set_gred
     if finale <= 35 
       "E"
     elsif finale <= 40
       "D"
     elsif finale <= 45
       "D+"
     elsif finale <= 50
       "C-"
     elsif finale <= 55
       "C"
     elsif finale <= 60
       "C+"
     elsif finale <= 65
       "B-"
     elsif finale <= 70
       "B"
     elsif finale <= 75
       "B+"
     elsif finale <= 80
       "A-"
     else
       "A"
     end
   end

   def set_NG
     if finale <= 35 
       0.00
     elsif finale <= 40
       1.00
     elsif finale <= 45
       1.33
     elsif finale <= 50
       1.67
     elsif finale <= 55
       2.00
     elsif finale <= 60
       2.33
     elsif finale <= 65
       2.67
     elsif finale <= 70
       3.00
     elsif finale <= 75
       3.33
     elsif finale <= 80
       3.67
     else
       4.00
     end
   end 

   #3June2013
   def self.search2(search)
       if search
           if search == '0'
               @grades = Grade.all
           else
               @grades = Grade.find(:all, :conditions=>['subject_id=?',search])
           end
       else
           @grades = Grade.all
       end
   end
     
#GRADE = [
  #  Displayed       stored in db
   # [ "75% - A","1" ],
   # [ "60% - B","2" ],
   # [ "55% - C", "3" ],
   # [ "35% - D", "4" ],
   # [ "<34% - F", "5" ]

#]
GRADE = [
  #  Displayed       stored in db
    [ "80-100% - A",  "1" ],
    [ "75-79% - A-",  "2" ],
    [ "70-74% - B+",  "3" ],
    [ "65-69% - B",   "4" ],
    [ "60-64% - B-",  "5" ],
    [ "60-63% - D",   "6" ],
    [ "55-59% - C+",  "7" ],
    [ "50-54% - C",   "8" ],
    [ "45-49% - C-",  "9" ],
    [ "40-44% - D+",  "10" ],
    [ "35-39% - D",   "11" ],
    [ "0-34% - E",    "12" ]
]

E_TYPES = [
    #  Displayed       stored in db
      [ "Clinical Work","1" ],
      [ "Assignment","2" ],
      [ "Project", "3" ],
      [ "Clinical Report", "4" ],
      [ "Test", "5" ],
      [ "Exam", "6" ],
      

]

WEIGHTAGE = [
    #  Displayed       stored in db
    [ '5 %',  5],
    [ '10 %', 10],
    [ '15 %', 15],
    [ '20 %', 20],
    [ '25 %', 25],
    [ '30 %', 30],
    [ '35 %', 35],
    [ '40 %', 40],
    [ '45 %', 45],
    [ '50 %', 50],
    [ '55 %', 55],
    [ '60 %', 60],
    [ '65 %', 65],
    [ '70 %', 70],
    [ '75 %', 75],
    [ '80 %', 80],
    [ '85 %', 85],
    [ '90 %', 90],
    [ '95 %', 95],
    [ '100 %', 100]

]


# code for repeating field score
# ---------------------------------------------------------------------------------

end
