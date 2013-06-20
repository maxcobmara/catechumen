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

  def self.get_subjects(programme_id,semester)#,examstartdate)
      @parent_sem = Programme.find(programme_id).descendants.at_depth(1)
      @parent_sem.each do |sem|
        @subjects_ids = sem.children.map(&:id) if sem.code == semester.to_s   #refer to semester no 
      end
      @subjects = Programme.find(:all, :conditions=>["id IN(?)",@subjects_ids])
      return @subjects
  end 
  
  #14March2013 - rev 18June2013
     def self.set_intake_group(examyear,exammonth,semester)    #semester refers to semester of selected subject - subject taken by student of semester???
        #@unit_dept = User.current_user.staff.position.unit
        #@unit_dept = User.current_user.staff.position.ancestors.at_depth(2)[0].unit if @unit_dept==nil
        
        #------------in case , error ..use the above 2 lines--------
       
        @anc_depth = User.current_user.staff.position.ancestry_depth
        @multi_position = Position.find(:all, :conditions => ['staff_id=?',User.current_user.staff_id])
        @ifmulti_position = @multi_position.count 
        if @anc_depth==2 
          @dept_unit = User.current_user.staff.position.unit
        elsif @anc_depth < 2 
        	if @ifmulti_position > 1 
        		@dept_unit = Position.find(:first,:conditions=>['staff_id=? and ancestry_depth=?', User.current_user.staff_id,2]).unit 	
        	end 
        	if @anc_depth==1 
        		@dept_unit = Position.find(:first,:conditions=>['staff_id=?', User.current_user.staff_id]).unit 
        	end 
        elsif @anc_depth > 2
        	if @ifmulti_position > 1 
        		@multi_position.each do |x|
        			if x.parent.id > 6 && x.parent.id < 17
        			  @dept_unit = x.parent.unit
        			end
        		end
        	else
        		@dept_unit = User.current_user.staff.position.ancestors.at_depth(2)[0].unit 
        	  if @dept_unit == "Pos Basik" && @anc_depth == 3
        			@dept_unit = User.current_user.staff.position.unit 
        	 end 
        end 
       end
       
       @current_user_roles=[]
       User.current_user.roles.each do |role|
       	  @current_user_roles<<role.id
       end 

     
     #if @current_user_roles.include?(2)
        
        #--------------------
        
         if (@dept_unit && @dept_unit == "Kebidanan" && exammonth.to_i <= 9) || (@dept_unit && @dept_unit != "Kebidanan" && exammonth.to_i <= 7)|| (@current_user_roles.include?(2) && exammonth.to_i <= 9)||(@dept_unit=="Ketua Unit Penilaian & Kualiti" && exammonth.to_i <= 9) #|| (@current_user_roles.include?(2) && exammonth.to_i <= 7) #(@dept_unit && @dept_unit == "Teknologi Maklumat" && exammonth.to_i <= 9)                                         # for 1st semester-month: Jan-July, exam should be between Feb-July
            @current_sem = 1 
            @current_year = examyear 
            if (semester.to_i-1) % 2 == 0                        					      # modulus-no balance
              @intake_year = @current_year.to_i-((semester.to_i-1)/2) 
              @intake_sem = @current_sem 
            elsif (semester.to_i-1) % 2 != 0                      				      # modulus-with balance
              @intake_year = @current_year.to_i-((semester.to_i+1)/2) 
              @intake_sem = @current_sem + 1 
      			end 
          elsif (@dept_unit&& @dept_unit == "Kebidanan" && exammonth.to_i > 9) || (@dept_unit && @dept_unit != "Kebidanan" && exammonth.to_i > 7) || (@current_user_roles.include?(2) && exammonth.to_i > 7)||(@dept_unit=="Ketua Unit Penilaian & Kualiti" && exammonth.to_i > 7)                                   # 2nd semester starts on July-Dec- exam should be between August-Dec
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
      		    @intake_month = '03' if( @dept_unit && @dept_unit == "Kebidanan") 
      		    @intake_month = '01' if @dept_unit && @dept_unit != "Kebidanan"  
      		    @intake_month = '03' if(@dept_unit && @current_user_roles.include?(2) && exammonth.to_i <=9 && exammonth.to_i > 7) 
      		    @intake_month = '03' if(@dept_unit=="Ketua Unit Penilaian & Kualiti" && exammonth.to_i <=9 && exammonth.to_i > 7)
      		elsif @intake_sem == 2
      		    @intake_month = '09' if (@dept_unit && @dept_unit == "Kebidanan") 
      		    @intake_month = '07' if @dept_unit && @dept_unit != "Kebidanan"
         		  @intake_month = '09' if(@dept_unit && @current_user_roles.include?(2) && exammonth.to_i >1 && exammonth.to_i <=3 ) 
      		    @intake_month = '03' if(@dept_unit=="Ketua Unit Penilaian & Kualiti" && exammonth.to_i >1 && exammonth.to_i <=3)    		  
      		end

      		return @intake_year.to_s+'-'+@intake_month+'-01'  #giving this format -->  2/2012
      end
      #14March2013
  
  
  def self.get_students(programme_id,examyear,exammonth,semester)
    @combine = self.set_intake_group(examyear,exammonth,semester)
    @all_students=[]
		#Student.find(:all, :conditions => ['programme_id=?', programme_id]).each do |student|
		Student.find(:all, :conditions => ['course_id=?', programme_id]).each do |student|
  	
		  #if student.intakestudent.name == @combine
		  if student.intake.to_s == @combine #'2011-07-01'#
  		
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
  
  def self.pngs17(finale_total,subject_credits)
    #finale_total/17
    #total_credit = Examresult.get_subjects(programme_id,semester).map(&:credits).inject{|sum,x|sum+x}
    finale_total/(subject_credits.inject{|sum,x|sum+x})
    
    #(subject_credits.inject{|sum,x|sum+x}) 
    #NGS [=finale_total]-> Nilai Gred Semester(JUM-Nilai gred(tiap subjek) * kredit(tiap subjek))
    #PNGS -> Purata Nilai Gred Semester(NGS/jum kredit); [jum kredit=(subject_credits.inject{|sum,x|sum+x})]
  end
  
  def self.pngk(student, semester, programmeid)#, finale_total, subject_credits) #for new records only
      #NGK - Nilai Gred kumulatif(Jumlah (nilai gred*kredit) terkumpul, PNGK - Purata Nilai Gred Kumulatif (NGK/jumlah kredit terkumpul)
      ngk = Resultline.find(:all, :conditions => ['student_id=?', student],:order => "created_at DESC").map(&:total).inject{|sum,x|sum+x}.to_f
      @all_sem = Programme.find(programmeid).descendants.at_depth(1)
			@sum_ct=0
			@all_sem.each do |sem|
				if sem.code <= semester
					@sum_ct += sem.descendants.map(&:credits).inject{|sum,x|sum+x}
				end
		  end
      accumulated_total_credit = @sum_ct
    
      return ngk/accumulated_total_credit
                                          
  end
  
  def self.status(pngs)
    return "1" if pngs>=3.67
    return "2" if pngs>=2.67
    return "3" if pngs>=2.0
    return "4" if pngs<2   
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
