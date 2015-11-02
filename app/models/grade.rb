class Grade < ActiveRecord::Base
  
  validates_presence_of :student_id, :subject_id, :examweight#, :exam1marks #added examweight for multiple edit - same subject - this item must exist
  validates_uniqueness_of :subject_id, :scope => :student_id, :message => " - This student has already taken this subject"
  
  belongs_to :studentgrade, :class_name => 'Student', :foreign_key => 'student_id'  #Link to Model student
  belongs_to :subjectgrade, :class_name => 'Programme', :foreign_key => 'subject_id'  #Link to Model subject

  has_many :scores, :dependent => :destroy
  accepts_nested_attributes_for :scores,:allow_destroy => true, :reject_if => lambda { |a| a[:description].blank? } #allow for destroy - 17June2013
  
  attr_accessor :programme_id, :final_exam_paper, :intake_id, :summative_weightage, :formative_scores_var,:summative_weightage2,:summative_weightage3,:summative_weightage4,:summative_weightage5,:summative_weightage6,:score_count,:student_count,:column_count, :form_weight, :formative_count
  before_save :save_bpl_sent_date
  
    def save_bpl_sent_date
      if sent_to_BPL == true && sent_date == nil
        self.sent_date = Date.today
      elsif sent_to_BPL == false
        self.sent_date = nil
      end
    end
    
    #23June2013---retrieve marks from exammarks & marks table to be inserted into 
    #...grades/_view_grades_form_multiple_subject.html.erb (line 206-207), exam1marks 's field
    def self.retrieve_final_exam_from_exammark(examid,studentid)
      exammark_id = Exammark.find(:all, :conditions => ['exam_id=? AND student_id=?', examid, studentid])
      @total_mcq = Exammark.find(exammark_id)[0].total_mcq
      subject_id = Exammark.find(exammark_id)[0].exampaper.subject_id
      total_marks = Mark.sum(:student_mark, :conditions => ["exammark_id=?", exammark_id])+@total_mcq
      credit_hour=Programme.find(subject_id).credits.to_i
      
      #------if marks entered already in weightage,...exam1marks = total_marks---------------------------------
      @total_marks = total_marks
      summative = total_marks.to_f*0.7
      #------------------------------use ABOVE formula for all conditions--HIDE ALL @credit_hour statement-----
      
      #if credit_hour == 3
         #@total_marks = total_marks.to_f/0.9
          ##summative = total_marks.to_f/0.9*0.7
      #elsif credit_hour == 4
          #@total_marks = total_marks.to_f/1.2
          ##summative = total_marks.to_f/1.2*0.7
      #elsif @credit_hour == 2
          #@total_marks = total_marks.to_f/0.7
          ##summative = total_marks.to_f/0.7*0.7
      #else
          #@total_marks = total_marks.to_f
          ##summative = total_marks.to_f*0.7
      #end
      
      return @total_marks
    end
    #23June2013---
  
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
    
    def total_formative2  #temporary - to confirm with user-marks to be entered in weightage or %
      Score.sum(:marks, :conditions => ["grade_id = ?", id])
    end
    
    def total_summative
      if exam1marks == 0
        0
      else
        (exam1marks * examweight)/100
      end
    end
    
    def finale
      score.to_f + total_summative    #23August2013
      #((exam1marks * examweight)/100) + ((total_formative * (100 - examweight)/100))
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
     if finale < 35  #<= 35 
       0.00
     elsif finale < 40 #<= 40
       1.00
     elsif finale < 45 #<= 45
       1.33
     elsif finale < 50 #<= 50
       1.67
     elsif finale < 55 #<= 55
       2.00
     elsif finale < 60 #<= 60
       2.33
     elsif finale < 65 #<= 65
       2.67
     elsif finale < 70 #<= 70
       3.00
     elsif finale < 75 #<= 75
       3.33
     elsif finale < 80 #<= 80
       3.67
     else
       4.00
     end
   end 
   
   def self.search2(search)
       if search
           @grades = Grade.find(:all, :conditions =>['subject_id IN(?)',search])
       else
           @grades = Grade.all
       end
   end
   
   #########
   #11Apr2013
   def self.set_error_messages(exammark_list)
 	  @exammarkerrors = []
 	  @exammarkerrors2 = []
 	  @exammarkerrors_full = []
     @errors_qty = 0
     exammark_list.each do |exammarksub|
       exammarksub.errors.each do |key,value|
           @key2 = key
           #@exammarkerrors << '<b>'+I18n.t('activerecord.attributes.exammark.'+key)+'</b>'+' '+value+'<br>'
 			    @exammarkerrors << '<b>'+I18n.t('activerecord.attributes.grade.'+key)+'</b>'+' '+value+'<br>'
 			    @errors_qty+=1
 		  end 	# end of exammarksub.errors.each do |key,value|
 	  end		# end of exammark_list.each do |exammarksub|
     if @errors_qty == 1
 			  @exammarkerrors2 <<'<b>'+@errors_qty.to_s+' error '
 	  elsif @errors_qty > 1
 			  @exammarkerrors2 <<'<b>'+@errors_qty.to_s+' errors '
 	  end
 	  @exammarkerrors2 << 'prohibited this record from being saved</b><br><br>'
 	  @exammarkerrors_full << @exammarkerrors2.to_s+@exammarkerrors.to_s
     return @exammarkerrors_full
   end
   #########
     
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
    [ "80-100% - A",  "A" ],
    [ "75-79% - A-",  "A-" ],
    [ "70-74% - B+",  "B+" ],
    [ "65-69% - B",   "B" ],
    [ "60-64% - B-",  "B-" ],
    [ "55-59% - C+",  "C+" ],
    [ "50-54% - C",   "C" ],
    [ "45-49% - C-",  "C-" ],
    [ "40-44% - D+",  "D+" ],
    [ "35-39% - D",   "D" ],
    [ "0-34% - E",    "E" ]
]

E_TYPES = [
    #  Displayed       stored in db
      [ "Clinical Work","1" ],
      [ "Assignment","2" ],
      [ "Project", "3" ],
      [ "Clinical Report", "4" ],
      [ "Test", "5" ],
      [ "Exam", "6" ]
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
