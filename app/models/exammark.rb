class Exammark < ActiveRecord::Base
  belongs_to :exampaper, :class_name =>'Exam', :foreign_key => 'exam_id'
  belongs_to :studentmark, :class_name => 'Student', :foreign_key => 'student_id'
  has_many :marks, :dependent => :destroy                                                     
  accepts_nested_attributes_for :marks#, :reject_if => lambda { |a| a[:mark].blank? }   #use of validates_presence_of in mark model
  
  before_save :set_total_mcq, :apply_final_exam_into_grade
  validates_presence_of   :student_id, :exam_id
  validates_uniqueness_of :student_id, :scope => :exam_id, :message => " - Mark of this exam for selected student already exist. Please edit/delete existing mark accordingly."
  
  attr_accessor :total_marks, :subject_id, :intake_id,:trial1,:trial2, :total_marks_view, :trial3, :total_mcq_in_exammark_single, :trial4
  
  def set_total_mcq
    if total_mcq==nil   #5June2013-added-calculate here if not assign in _view_marks_form(otal_mcq==nil)
      count=0
      @examquestions = Exam.find(:first, :conditions=>['id=?', exam_id]).examquestions
      @examquestions.each do |x|
          if x.questiontype=="MCQ"
            count+=1
          end
      end
      @allmarks = Mark.find(:all, :conditions => ["exammark_id=?", self.id])
      @sum_mcq = 0
      @allmarks.each_with_index do |y, index|
          if index< count
            @sum_mcq +=y.student_mark
          end
      end
      if self.total_mcq != 0 && @sum_mcq == 0     #in case - only total MCQ entered instead of entering each of MCQ marks
      else
        self.total_mcq = @sum_mcq       
      end
    end               #5June2013-added-calculate here if not assign in _view_marks_form(otal_mcq==nil)
  end
  
  def total_marks
	  if self.id	
      return Mark.sum(:student_mark, :conditions => ["exammark_id=?", self.id])+total_mcq.to_i
    else
      @total_marks	#any input by user will be ignored either edit form or new (including re-submission-invalid data)
					          #value assigned from partial..(1) single entry(_form.html.erb-line 44-47) (2) multiple entry(_form_by_paper.html.erb-line88-91)
    end
  end
  
  #11Apr2013
  def self.set_error_messages(exammark_list)
	  @exammarkerrors = []
	  @exammarkerrors2 = []
	  @exammarkerrors_full = []
    @errors_qty = 0
    exammark_list.each do |exammarksub|
      exammarksub.errors.each do |key,value|
          @key2 = key
			    @exammarkerrors << '<b>'+I18n.t('activerecord.attribute.exammark.'+key)+'</b>'+' '+value+'<br>'
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
  
  def self.fullmarks(exam_id)
      @istemplate = Exam.find(exam_id).klass_id
      if @istemplate == 0 
        fullmarks = Exam.find(exam_id).examtemplates.map(&:total_marks).inject{|sum,x|sum+x}
      else
        fullmarks = Exam.find(exam_id).examquestions.map(&:marks).to_a.inject{|sum,x|sum+x}
      end
      fullmarks
  end
  
  #11June2013---updated 23June2013
  def apply_final_exam_into_grade
    @subject_id = Exam.find(exam_id).subject_id
    @examtype = Exam.find(exam_id).name
    fullmarks = Exammark.fullmarks(exam_id)
    @grade_to_update = Grade.find(:first, :conditions=> ['student_id=? and subject_id=?', student_id, @subject_id])
    #@credit_hour=Programme.find(@subject_id).credits.to_i
    
    unless @grade_to_update.nil? || @grade_to_update.blank?
        #if @credit_hour == 3
          # if marks entered not in weightage marks, eg, weightage : mcq=40%(40 que), seq=30%(4 que=40marks), but marks were entered according to actual total marks : 80/80 (but weightage 70%) 
          # TEMPORARY use these FORMULA --> total_marks.to_f/0.9,total_marks.to_f/0.7,total_marks.to_f/1.2  .....OR ELSE
          
          #------if marks entered already in weightage,...exam1marks = total_marks---------------------------------
          @grade_to_update.exam1marks = total_marks.to_f
          @grade_to_update.summative = total_marks.to_f/fullmarks.to_f*70 #REQUIRES FORMULA HERE --> SEE ABOVE EXAMPLE ...LINE 76
          #------------------------------use ABOVE formula for all conditions--HIDE ALL @credit_hour statement-----
          
	        #@grade_to_update.exam1marks = total_marks.to_f/0.9        #depends on weightage 
	        #@grade_to_update.summative = total_marks.to_f/0.9*0.7
        #elsif @credit_hour == 4
          #@grade_to_update.exam1marks = total_marks.to_f/1.2        #depends on weightage
          #@grade_to_update.summative = total_marks.to_f/1.2*0.7
        #elsif @credit_hour == 2
          #@grade_to_update.exam1marks = total_marks.to_f/0.7        #depends on weightage
          #@grade_to_update.summative = total_marks.to_f/0.7*0.7
        #else
          #@grade_to_update.exam1marks = total_marks.to_f            #depends on weightage
          #@grade_to_update.summative = total_marks.to_f*0.7
        #end
        @grade_to_update.save if @grade_to_update.exam1marks && @examtype == "F"  #F for Peperiksaan Akhir Semester
    end
  end
  #11June2013------updated 23June2013
  
  #14March2013 - rev 17June2013
  def self.set_intake_group(examyear,exammonth,semester)    #semester refers to semester of selected subject - subject taken by student of semester???
    @unit_dept = User.current_user.staff.position.unit
    #@unit_dept = User.current_user.staff.position.ancestors.at_depth(2)[0].unit if @unit_dept==nil
     
     #if exammonth.to_i <= 7
     if (@unit_dept && @unit_dept == "Kebidanan" && exammonth.to_i <= 9) || (@unit_dept && @unit_dept != "Kebidanan" && exammonth.to_i <= 7)                                           # for 1st semester-month: Jan-July, exam should be between Feb-July
        @current_sem = 1 
        @current_year = examyear 
        if (semester.to_i-1) % 2 == 0                        					      # modulus-no balance
          @intake_year = @current_year.to_i-((semester.to_i-1)/2) 
          @intake_sem = @current_sem 
        elsif (semester.to_i-1) % 2 != 0                      				      # modulus-with balance
          #29June2013-@intake_year = @current_year.to_i-((semester.to_i+1)%2)           #@intake_year = @current_year.to_i-((semester.to_i+1)%2) --> giving error : 2043/2
          #29June2013-------------------OK
          if (semester.to_i+1)/2 > 3  
            @intake_year = @current_year.to_i-((semester.to_i+1)%2)-2
          elsif (semester.to_i+1)/2 > 2
            @intake_year = @current_year.to_i-((semester.to_i+1)%2)-1
          elsif (semester.to_i+1)/2 > 1
            @intake_year = @current_year.to_i-((semester.to_i+1)%2)
          end  
          #29June2013-------------------
          @intake_sem = @current_sem + 1 
  			end 
      elsif (@unit_dept && @unit_dept == "Kebidanan" && exammonth.to_i > 9) || (@unit_dept && @unit_dept != "Kebidanan" && exammonth.to_i > 7)                                                  # 2nd semester starts on July-Dec- exam should be between August-Dec
      #elsif exammonth.to_i > 7
        @current_sem = 2 
        @current_year = examyear
        if (semester.to_i-1) % 2 == 0  
          @intake_year = @current_year.to_i-((semester.to_i-1)/2).to_i				
          @intake_sem = @current_sem 
        elsif (semester.to_i-1) % 2 != 0                   					        # modulus-with balance
          #29June2013-@intake_year = @current_year.to_i-((semester.to_i-1)%2).to_i      # (hasil bahagi bukan baki..)..cth semester 6 
           #29June2013-------------------
            if (semester.to_i+1)/2 > 3  
              @intake_year = @current_year.to_i-((semester.to_i+1)%2)-2
            elsif (semester.to_i+1)/2 > 2
              @intake_year = @current_year.to_i-((semester.to_i+1)%2)-1
            elsif (semester.to_i+1)/2 > 1
              @intake_year = @current_year.to_i-((semester.to_i+1)%2)
            end  
            #29June2013-------------------
          @intake_sem = @current_sem - 1
        end 
      end
  		#return @intake_sem.to_s+'/'+@intake_year.to_s   #giving this format -->  2/2012  --> previously done on examresult(2012)
  		
  		if @intake_sem == 1 
  		    @intake_month = '03' if @unit_dept && @unit_dept == "Kebidanan"
  		    @intake_month = '01' if @unit_dept && @unit_dept != "Kebidanan"
  		elsif @intake_sem == 2
  		    @intake_month = '09' if @unit_dept && @unit_dept == "Kebidanan"
  		    @intake_month = '07' if @unit_dept && @unit_dept != "Kebidanan"
  		end
  		
  		return @intake_year.to_s+'-'+@intake_month+'-01'  #giving this format -->  2/2012
  end
  #14March2013
  
  def self.search2(search)
      if search
          @exammarks = Exammark.find(:all, :conditions =>['exam_id IN(?)',search])
      else
          @exammarks = Exammark.all
      end
  end
  
end
