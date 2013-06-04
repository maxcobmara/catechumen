class Exammark < ActiveRecord::Base
  belongs_to :exampaper, :class_name =>'Exam', :foreign_key => 'exam_id'
  belongs_to :studentmark, :class_name => 'Student', :foreign_key => 'student_id'
  has_many :marks, :dependent => :destroy                                                     
  accepts_nested_attributes_for :marks#, :reject_if => lambda { |a| a[:mark].blank? }   #use of validates_presence_of in mark model
  
  before_save :set_total_mcq
  
  validates_uniqueness_of :student_id, :scope => :exam_id, :message => " - Mark of this exam for selected student already exist. Please edit/delete existing mark accordingly."
  
  attr_accessor :total_marks, :subject_id, :intake_id
  
  #14Apr2013-if done this way-UPDATE-method (refer controller) --> data updates not working.
  #def set_total_mcq  #hold first
        #if self.total_mcq!=nil
            #sum_mcq=0
            #@questions_mcqq = Exam.find(:all,:conditions=> ['id=?', exam_id])[0].examquestions.mcqq.count
            #@marks = marks.dup
           #@marks2 = @marks.sort_by{|x|x.id}
            #@marks2.each_with_index do |mark, index|
                #if index < @questions_mcqq
                    #sum_mcq+=mark.student_mark
                #end
            #end 
            #self.total_mcq = sum_mcq
        #end
  #end
  def set_total_mcq
      #self.total_mcq = Mark.sum(:student_mark, :conditions => ["exammark_id=?", self.id]) ##MCQ ONLY!!
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
      #@sum_mcq = @allmarks[0].student_mark+@allmarks[1].student_mark
      if self.total_mcq != 0 && @sum_mcq == 0     #in case - only total MCQ entered instead of entering each of MCQ marks
      else
        self.total_mcq = @sum_mcq       
      end
  end
  
  def total_marks
	  if self.id	
	    #if total_mcq==nil
        #return Mark.sum(:student_mark, :conditions => ["exammark_id=?", self.id])
      #elsif total_mcq!=nil
        #if(Mark.find(:all, :conditions => ["exammark_id=?", self.id]).count ) < Exam.find(:first, :conditions=>['id=?', exam_id]).examquestions.count
          #return Mark.sum(:student_mark, :conditions => ["exammark_id=?", self.id])+total_mcq  #total_mcq (if exammark entered in multiple)
        #elsif (Mark.find(:all, :conditions => ["exammark_id=?", self.id]).count ) == Exam.find(:first, :conditions=>['id=?', exam_id]).examquestions.count
          #return Mark.sum(:student_mark, :conditions => ["exammark_id=?", self.id])#.to_s+"bbb"
        #else
          #return Mark.sum(:student_mark, :conditions => ["exammark_id=?", self.id])+total_mcq  #total_mcq (if exammark entered in multiple)
        #end 
      #end
      return Mark.sum(:student_mark, :conditions => ["exammark_id=?", self.id])#+total_mcq.to_i
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
          #@exammarkerrors << '<b>'+I18n.t('activerecord.attributes.exammark.'+key)+'</b>'+' '+value+'<br>'
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
  
  def self.update_single_exam1mark_in_grades(exammaker_id,student_id,all_marks)
    @subject_id = Exammaker.find(exammaker_id).subject_id
    @examtype = Exammaker.find(exammaker_id).examtype
    @grade1 = Grade.find(:first, :conditions=> ['student_id=? and subject_id=?', student_id, @subject_id])
    @sum_of_marks = Exammark.sum_marks(all_marks)  #@all_marks["0"]["mark"]
    unless @grade1.nil? || @grade1.blank?
      @grade1.exam1marks = @sum_of_marks
      @grade1.save if @grade1.exam1marks && @examtype == "2"  #2 for Peperiksaan Akhir Semester
    end
  end
  
  #14March2013
  def self.set_intake_group(examyear,exammonth,semester)
     if exammonth.to_i <= 7                                                # for 1st semester-month: Jan-July, exam should be between Feb-July
        @current_sem = 1 
        @current_year = examyear 
        if (semester.to_i-1) % 2 == 0                        					      # modulus-no balance
          @intake_year = @current_year.to_i-((semester.to_i-1)/2) 
          @intake_sem = @current_sem 
        elsif (semester.to_i-1) % 2 != 0                      				      # modulus-with balance
          @intake_year = @current_year.to_i-((semester.to_i+1)/2) 
          @intake_sem = @current_sem + 1 
  			end 
      elsif exammonth.to_i > 7                                              # 2nd semester starts on July-Dec- exam should be between August-Dec
        @current_sem = 2 
        @current_year = examyear
        if (semester.to_i-1) % 2 == 0  
          @intake_year = @current_year.to_i-((semester.to_i-1)/2) 				
          @intake_sem = @current_sem 
        elsif (semester.to_i-1) % 2 != 0                   					        # modulus-with balance
          @intake_year = @current_year.to_i-((semester.to_i-1)/2).to_i      # (hasil bahagi bukan baki..)..cth semester 6 
          @intake_sem = @current_sem - 1
        end 
      end
  		#return @intake_sem.to_s+'/'+@intake_year.to_s   #giving this format -->  2/2012  --> previously done on examresult(2012)
  		
  		if @intake_sem == 1
  		    @intake_month = '01'
  		elsif @intake_sem == 2
  		    @intake_month = '07'
  		end
  		return @intake_year.to_s+'-'+@intake_month+'-01'  #giving this format -->  2/2012
  end
  #14March2013
  
  #2June2013
  def self.search2(search)
      if search
          if search == '0'
              @exammarks = Exammark.all
          else
              @exammarks = Exammark.find(:all, :conditions=>['exam_id=?',search])
          end
      else
          @exammarks = Exammark.all
      end
  end
  
end
