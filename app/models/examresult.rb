class Examresult < ActiveRecord::Base
  validates_presence_of :semester, :programme_id
  #ref:http://stackoverflow.com/questions/923796/how-do-you-validate-uniqueness-of-a-pair-of-ids-in-ruby-on-rails
  validates_uniqueness_of :semester, :scope => [:programme_id, :examdts], :message => ", Programme and Examination Date has already been taken. Only 1 record permitted for each examination result. "
  belongs_to :programmestudent, :class_name => 'Programme', :foreign_key => 'programme_id' 
  has_many :resultlines, :dependent => :destroy                                                     
  accepts_nested_attributes_for :resultlines, :reject_if => lambda { |a| a[:student_id].blank? }
   
  def render_semester
    (Examresult::SEMESTER.find_all{|disp, value| value == semester}).map {|disp, value| disp}
  end

  def self.get_subjects(programme_id,intake)
    #@programme_subjects = Programme.find(:all, :include=> :subjects, :conditions=>['programme_id=? and subjects.semester=?',programme_id,semester])
   @programme_subjects = Programme.find(:all, :conditions => ['ancestry_depth=?',2])
   @proramme_subjects = Programme.find(:all, :conditions=>[])
   #@students = Student.find(:all, :conditions=>['course_id=? and intake=? and gender=?',3,'2011-07-01',1])
   
   return @students = Student.find(:all, :conditions=>['course_id=? and intake=?',programme_id,intake])
   
    #unless @programme_subjects.blank? || @programme_subjects.nil?
      #@prog_subjects=[]
      ##@programme_subjects[0].subjects.each do |prog_subject|
      #@programme_subjects.each do |prog_subject|
        #@prog_subjects << prog_subject
      #end
    #end
    #return @prog_subjects
  end 
  
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
  		#return @intake_sem.to_s+'/'+@intake_year.to_s
  		return @intake_year.to_s+'-'+@intake_sem.to_s+'-01'
  		
  end
  
  def self.get_students(programme_id,examyear,exammonth,semester)
    @combine = self.set_intake_group(examyear,exammonth,semester)
    @all_students=[]
		#Student.find(:all, :conditions => ['programme_id=?', programme_id]).each do |student|
		Student.find(:all, :conditions => ['course_id=?', programme_id]).each do |student|
  	
		  #if student.intakestudent.name == @combine
		  if student.intake.to_s == '2011-07-01'#@combine
  		
		    @all_students << student
		  end
		end
		return @all_students
  end
  
  def self.grade_student_subjects(studentid)
    @grade_per_student = Grade.find(:all, :conditions =>['student_id=?',studentid])
		@subjects_student = []
		@grade_per_student.each do |grade_student|
			@subjects_student << grade_student.subject_id
		end
		return @subjects_student
  end
  
  def self.total(finale_all,subject_credits)
    @finaletotal = 0.00
    0.upto(finale_all.count-1) do |index|
      @finaletotal = @finaletotal+(finale_all[index]*subject_credits[index])
    end
    return @finaletotal
  end
  
  def self.pngs17(finale_total)
    finale_total/17
  end
  
  def self.get_result_sem(intakebydate,semester)
    @sem1_result = [] 
		@sem2_result = [] 
		intakebydate.each_with_index do |value, index| 
		  if value.examdts.month.between?(1,6) 
				@sem1_result << value 
		  elsif value.examdts.month.between?(7,12) 
			  @sem2_result << value 
			end 
 		end 
 		return @sem1_result if semester==1 || semester=='1'
 		return @sem2_result if semester==2 || semester=='2'
  end
  
  def self.get_result_all(examresult_id)
    @examresult_A = [] 
		@examresults_intakes = Examresult.all.group_by { |t| t.programme_id } 
		@examresults_intakes.each do |programmeid, examresult| 
			@examresults_intakebydate = examresult.group_by { |t| t.examdts } 
			@examresults_intakebydate.each do |examdate,intakebydate| 
				intakebydate.each_with_index do |value, index| 
					if value.id == examresult_id 
						return intakebydate
					end
				end
			end
		end
	end
  
  # count total of passed/failed from examresults(resultlines) table - examresult/show_summary.html.erb
  def self.total_passed_failed(examresultA,passedfailed)
    @total_passed = 0
    @total_failed = 0
    for examresultline in examresultA.resultlines 
		  @total_passed+=1 if examresultline.status == 1 || examresultline.status == '1' 
			@total_failed+=1 if examresultline.status == 2 || examresultline.status == '2' 
    end 
    return @total_passed if passedfailed == 1 || passedfailed == '1'
    return @total_failed if passedfailed == 2 || passedfailed == '2'
  end
  
  def self.passed_failed_percentage(total,quantity)
    total/quantity * 100 
  end
  
  #(@pass_rate/@total_NG_A.count.to_f) * 100 
  
  def self.studentNG_in_hash(student_id,subjects,countNG) 
    @arrayNG = [] 
		for subject in subjects 
			@student_finale = Grade.find(:first, :conditions=> ['student_id=? and subject_id=?',student_id,subject.id]) 
			unless @student_finale.nil? || @student_finale.blank? 
				@arrayNG << @student_finale.set_NG.to_f
			else 
				@arrayNG << 0.00 
			end 
		end 
		@hashNG = {countNG.to_s=>@arrayNG} if countNG == 0 
		@hashNG = @hashNG.merge({countNG.to_s=>@arrayNG}) if countNG > 0 
		return @hashNG
  end
  
  def self.hashNG_to_a(hashNG,index)
    @total_NG_A = [] 
    hashNG.each do |k,v| 
      v.each_with_index do |value,vcount|
        if vcount == index 
          @total_NG_A << value
        end 
      end 
    end 
    return @total_NG_A
  end
  
  SEMESTER = [
              #  Displayed       stored in db
              [ "Tahun 1/Semester I","1" ],
              [ "Tahun 1/Semester II","2" ],
              [ "Tahun 2/Semester I","3" ],
              [ "Tahun 2/Semester II","4" ],
              [ "Tahun 3/Semester I","5" ],
              [ "Tahun 3/Semester II","6" ],

  ]
  
    
end
