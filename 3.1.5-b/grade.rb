class Grade < ActiveRecord::Base

  validates_presence_of :student_id, :subject_id, :exam1marks, :examweight, :exam1name
  validates_numericality_of :exam1marks, :examweight
  validates_uniqueness_of :subject_id, :scope => :student_id, :message => " - This student has already taken this subject. Please edit/delete existing grade accordingly."
  validates_inclusion_of :exam1marks, :in => 0..100, :message => "should be between 0 to 100"   #-- 6 June 2012
  validate :subject_id_is_compulsory 
  validate :examweight_is_compulsory
  
  belongs_to :studentgrade, :class_name => 'Student', :foreign_key => 'student_id'  #Link to Model student
  belongs_to :subjectgrade, :class_name => 'Subject', :foreign_key => 'subject_id'  #Link to Model subject

  has_many :scores, :dependent => :destroy                                                      #-- 16 May 2012 -- #FK grade_id
  accepts_nested_attributes_for :scores, :reject_if => lambda { |a| a[:description].blank? }    #No scores data will be saved in db if description is not exist.  
                                                                                                #Once description exist for particular item, additional data (ie marks, weightage & type_id) will become compulsory.
  # REMARK- attr_accessor :scores_attributes                                                    #if declared as virtual attributes...no longer become...attributes for scores table...
  
  attr_accessor :formativecount
  attr_accessor :formativetype_ids	
  attr_accessor :formative_weightages             
  attr_accessor :subject_id_all
  attr_accessor :examweight_all
  
  # 22 May 2012
  ## CA + MSE (excel file) = (total_formative * (100 - examweight)/100)
  # sample : 19.34 = 64.47 x (100 - 70)/100   (note: examweight => summative weightage) [assumption-only 1 item of score for final/summative]
  
  def ca_plus_mse
    total_formative * (100 - examweight)/100
  end
  
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
      #-----------------------------------------------------------------------------------------------
      # finale (grade.rb) = Total Mark(excel file) = Final Exam (excel file) + [CA + MSE (excel file)] 
      #-----------------------------------------------------------------------------------------------
      # whereby...
      # (1) in excel file, Final Exam = (MCQ + Total SEQ)/0.9] (value 0.9 may differs depends on subject)
      # (2) in grade.rb, Final Exam = exam1marks
      # (3) in exammark.rb, Final Exam = total_marks....a virtual attribute...which obtain it's value from.....
      # (4) in mark.rb, Final Exam = sum of marks value for selected exammark (of exampaper)
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
    
  #-------- 22 May 2012 ----------for search by subject
  def self.search2(search2)
    if search2 
        if search2 != '0'
           @grades = Grade.find(:all, :conditions => ["subject_id=?", search2 ], :order => :created_at)
        else
           @grades = Grade.find(:all)
        end
    else
        @grades = Grade.find(:all)
    end
  end
  #-------- 22 May 2012 ----------for search by subject
  
  #--------------------26 June 2012--------------------
  def self.all_grades_in_hash(grades_all)
    #Hash[*grades_all].sort_by(&:first)
    Hash[grades_all].sort_by(&:first)
  end  
 
  def self.data_from_hash(grades_all,data_for) 
    @h = self.all_grades_in_hash(grades_all)
    @d = []
    if data_for == 0
      #@d << @h[0][0][1][:subject_id_all] 
      #@d << @h[0][0][1][:formativecount]
      #@d << @h[0][0][1][:formativetype_ids]
      #@d << @h[0][0][1][:formative_weightages] 
      #@d << @h[0][0][1][:examweight_all]
      @h.each do |k,v| 
    	  if k=='0' || k==0 
    		  v.each do |key, value|
    			  if key == 'subject_id_all'
    			    @d[0] = value
    			  elsif key == 'formativecount'
    			    @d[1] = value
    			  elsif key == 'formativetype_ids'
      			  @d[2] = value
      		  elsif key == 'formative_weightages'
        	    @d[3] = value
        	  elsif key == 'examweight_all'
          	  @d[4] = value
    			  end
    		  end
    		end
    	end 
    
    elsif data_for == 1  
      
      #if grades_all.count % 2 == 0    #grades_count ==> genab
        #0.upto(grades_all.count/2-1) do |index| 
          #@d << @h[index][0][1][:student_id] 
		      #@d << @h[index][0][1][:exam1marks] 
		      #@d << @h[index][1][1][:student_id] 
		      #@d << @h[index][1][1][:exam1marks] 
          
          #---
          @count=0
          @h.each do |k,v| 
        		if k!=0 || k!='0'
        		  v.each do |key, value|
        			  if key == 'student_id'
        			    @d[@count] = value
        			    @count+=1
        			  elsif key == 'exam1marks'
        			    @d[@count] = value
        			    @count+=1
        			  end
        		  end
            end
         # end
          #---
        #end
      
        
      #else  #grades_count ==> ganjil
       # 0.upto((grades_all.count-1)/2) do |index|
          #if index == grades_all.count-1/2
            #@d << @h[index][0][1][:student_id] 
   		      #@d << @h[index][0][1][:exam1marks] 
   		    #else
   		      #@d << @h[index][0][1][:student_id] 
   		      #@d << @h[index][0][1][:exam1marks]
   		      #@d << @h[index][1][1][:student_id] 
   		     # @d << @h[index][1][1][:exam1marks] 
   		    #end
        #end
      end
    
    elsif data_for == 2
      0.upto(grades_all.count/2-1) do |index|
			  #0.upto(1) do |count|
					#@d << @h[index][count][1][:scores_attributes]
				#end
				#---
				@h.each do |k,v| 
      		if k!=0 || k!='0'
      		  v.each do |key, value|
      			  if key == 'scores_attributes'
      			    @d << value
      		    end
      		  end
          end
        end
  			#---
			end
		elsif data_for == 3 #-----this part for multiple new grade by subjects...different at subject_id 
		  #@d << @h[0][0][1][:subject_id] #...already available for each grade ---via form @index page
		  #@d << @h[0][0][1][:formativecount] 
		  #@d << @h[0][0][1][:formativetype_ids]
      #@d << @h[0][0][1][:formative_weightages] 
      #@d << @h[0][0][1][:examweight_all]
      #---
     
  
      @h.each do |k,v| 
    	  if k=='0' || k==0      #########################################
    		  v.each do |key, value|
    			  if key == 'subject_id'
    			   @d[0] = value
				   #@d<< value
    			  elsif key == 'formativecount'
    			    @d[1] = value
				   #@d<< value
    			  elsif key == 'formativetype_ids'
					@d[2] = value
					#@d<< value
				  elsif key == 'formative_weightages'
					@d[3] = value
					#@d<< value
				  elsif key == 'examweight_all'
					@d[4] = value
					#@d<< value
    			  end   #end for if key...
    			  #@d << key+'-'+value+'/'
    		  end   #end for v.each 
    		  
    		end   #end for if k==0
    	end   #end for @h.each
       
      
      #---
      
    end   #end... for elsif data for 3
  
    return @d
   end  #end for def self.data_from_hash(grades_all,data_for) 
  

  
  #--------start of - for repeated submission due to previously invalid data sent--22 May - 11 June 2012 ---------------------------
  def subject_id_all 
    @subject_id_all.to_i
  end
 
  def examweight_all
    @examweight_all.to_i
  end
  
  def self.set_virtual_attribute_value(grade_list,datatype_for)
    @count_grade = 0
    grade_list.each do |gradeline|
        if @count_grade == 0 
            if datatype_for == 0
                return gradeline.subject_id_all.to_i                 # working format - @try = gradeline.exam1marks.to_i.to_s
            elsif datatype_for == 1
                return gradeline.examweight_all.to_i 
            elsif datatype_for == 2
                return gradeline.formativecount.to_i                #ref - line 145-147
            elsif datatype_for == 3
                return gradeline.formativetype_ids
            elsif datatype_for == 4
                return gradeline.formative_weightages
            end
        end
        @count_grade+=1
    end  
  end
  

  
  def self.is_not_a_number?(s)    #http://railsforum.com/viewtopic.php?id=19081 -- specious moderator - 2008-06-10 03:51:27
    s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? true : false 
  end
  #--------- end of - for repeated submission due to previously invalid data sent--22 May - 11June 2012 ----------------------------
  
  #--------- start of setting of error messages ---------------------------------28 May 2012 - 20 June 2012 -----------------------
  # SETTING CUSTOM MESSAGES ERRORS...FOR MULTIPLE GRADE RECORDS..REFERENCE
  #-----------------------------------------------------------------------
  # REF: http://kazimanzurrashid.com/posts/post-redirect-get-prg-in-rails  
  # @grd = params[:grade][:exam1marks]  
     #if @grade.invalid?
          #@gradeerrors = []
          #@gradeerrors = '<h3>'+ 'pluralize(@grade.errors.count, "error")'+'prohibited this record from being saved</h3>'
          #@grade.errors.each do |key,value|
              #@gradeerrors << '<b>'+t('activerecord.attributes.grade.'+key)+'</b>'+' '+value+'<br>'
          #end
     #end
     #...respond to do...if @grade.save... else...
     #flash[:notice] = 'Data supplied was invalid. Grade was not created.'    # 1-combination student+subject must unique, 2-all fields indicated with red * are compulsory
     #flash[:grade] = @grd                                                    # 3-marks & summative weightage must be a number
     #flash[:error] = @gradeerrors  #red box                                  # http://kazimanzurrashid.com/posts/post-redirect-get-prg-in-rails
     #flash.discard
  #----------------------------------------------------------------------
  def self.set_error_messages(grade_list,subject_id_4_all,examweight_4_all,student_dup_count)
    @gradeerrors = []
	  @gradeerrors2 = []
	  @gradeerrors_full = []
    @errors_qty = 0
    grade_list.each do |gradesub|
      gradesub.errors.each do |key,value|
          @key2 = key
			    @gradeerrors << '<b>'+I18n.t('activerecord.attributes.grade.'+key)+'</b>'+' '+value+'<br>'
			    #--------- for subject_id -------------
			    @z = (key <=> 'subject_id') 
  			  if @z == 0                                      # compare when key is 'subject_id' => (when @subject_id_4_all == '0' )
  			      @gradeerror1 = 1
  			  end 
  			  #--------------------------------------
  			  #--------- for examweight -------------
  			  @y = (key <=> 'examweight') 
  			  if @y == 0                                      # compare when key is 'subject_id' => (when @subject_id_4_all == '0' )
  			      @gradeerror2 = 1
  			  end
    			#--------------------------------------
				  @errors_qty+=1
		  end 	# end of gradesub.errors.each do |key,value|
	  end		# end of grade_list.each do |gradesub|
	  
	  if subject_id_4_all == '0' && @gradeerror1 != 1
          @gradeerrors << 'Please select <b>Subject</b><br>'     
		      @errors_qty+=1
    end    
    if examweight_4_all == '0' && @gradeerror2 != 1
          @gradeerrors << 'Please select <b>Summative Weightage</b><br>'
		      @errors_qty+=1
    end 
    if student_dup_count != 0 
          @gradeerrors << 'Please re-select <b>Student</b>, only one record permitted for each student<br>'
		      @errors_qty+=1
    end
    if @errors_qty == 1
			    @gradeerrors2 <<'<b>'+@errors_qty.to_s+' error '
	  elsif @errors_qty > 1
			    @gradeerrors2 <<'<b>'+@errors_qty.to_s+' errors '
	  end
	  @gradeerrors2 << 'prohibited this record from being saved</b><br><br>'
	  @gradeerrors_full << @gradeerrors2.to_s+@gradeerrors.to_s
    return @gradeerrors_full
  end  
  #--------- end of setting of error messages ---------------------------------28 May 2012-20 June 2012 -------------------------
  
  #----- start of setting of formativecount ------------------------------------ 5-6 June 2012 ----------------------------------
  def formativecount
 	  @formativecount.to_i  #default 0
  end
  #----- end of setting of formativecount ------------------------------------ 5-6 June 2012 ------------------------------------
  
  #----- start of setting of formativetype_ids ------------------------------- 5-6 June 2012 ------------------------------------
  def formativetype_ids
     @formativetype_ids         # "formativetype_ids" => {"0"=>"6", "1"=>"5"}
  end 
  #----- end of setting of formativecount ------------------------------------ 5-6 June 2012 ------------------------------------
  
  #----- start of setting of formative_weightages----------------------------- 6-7 June 2012 ------------------------------------
  def formative_weightages
	    @formative_weightages
  end
  #----- end of setting of formative_weightages------------------------------- 6-7 June 2012 ------------------------------------
  
  #-- start of setting value of ONLY available options of subject for current student - 17-18 May 2012 --------------------------
  def self.set_subject_for_multiple_edit(student_id)
	    @gradesperstudent = Grade.find(:all, :include => [:subjectgrade,:studentgrade], :conditions => ['student_id=?', student_id] ) 
		  @bil_grade = @gradesperstudent.count
		  @counter=0
		  @condition = '' 

		  @gradesperstudent.each do |gradeperstudent| 
			    if @counter < @bil_grade-1
				      @condition = @condition+'id!='+ gradeperstudent.subject_id.to_s+' and ' 
			    else 
				      @condition = @condition+'id!='+ gradeperstudent.subject_id.to_s	
			    end 
			    @counter+= 1
		  end
		
		  #--------- use FORMAT 1 instead of FORMAT 2-18 May 2012--------------
		  @allsubject_except_exist2 = Subject.find(:all, :conditions=> [@condition])
		  # FORMAT 1: @allsubject_except_exist = Subject.find(:all, :conditions=> ['id!=16 and id!=6 and id!=9']) 
		  # FORMAT 2: @allsubject_except_exist = Subject.find(:all, :conditions=> ['id!=? and id!=? and id!=?',16,6,19]) 
		  #--------------------------------------------------------------------
  end
  #-- end of setting value of ONLY available options of subject for current student - 17-18 May 2012 --------------------------
    
  #-- start of validation of subject for each student-----18-22 May 2012---------------- 
  def self.check_subject_each_student_not_redundant(allsubjects,allstudents,totalgrades)
  	  @student_subject = []  
  		@students_subjects_in_string = ""        
      totalgrades.downto(0) do |count|
          @a_student = allstudents[count]
          @a_subject = allsubjects[count]
          @students_subjects_in_string = @students_subjects_in_string + @a_student.to_s+","+ @a_subject.to_s
          if count !=0
            	@students_subjects_in_string = @students_subjects_in_string + ";"
          end
      end
        
      #--Transform students_subjects from string format to ordered hash format
      #--REFERENCE : (1)http://stackoverflow.com/questions/2182464/string-to-array-and-hash-with-regexp
      #------------: (2) http://stackoverflow.com/questions/7136936/how-can-i-group-this-array-of-hashes
      #--SAMPLE : string format -> ("14,5;2,5;14,4;2,4")
      #---------: ordered hash format -> #<OrderedHash {"14"=>[{:student_id=>"14", :subject_id=>"5"}, {:student_id=>"14", :subject_id=>"4"}], "2"=>[{:student_id=>"2", :subject_id=>"5"}, {:student_id=>"2", :subject_id=>"4"}]}>
      #--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      @students_subjects_in_orderedhash = @students_subjects_in_string.split(/;/).map{|i| Hash[[[:student_id, :subject_id],i.split(/,/)].transpose]}.to_a.group_by{|item| item[:student_id]}  
      @students_subjects_in_orderedhash.each do |key,val|     		#loop each student @students_subjects_in_orderedhash (sample : {"14"=>[{:student_id=>"14", :subject_id=>"5"},......] ..to access )
			    val.each do |subject|			                    		#loop-each subject of a student
				      @student_subject << subject                     		#subject refers subject_id whereas @student_subject is an array of subjects for a student
    		  end
          @subject_dup_count = self.get_quantity_duplicates_subject(@student_subject)		#DRY
			    if @subject_dup_count > 0
    		      return false 			                              	#return false when there's a duplicate exist
  			  else
    		      #do nothing here		                            	#ignores if no duplicate & let checking continues with other students-subject until all check is done & if all true-> return true -line 102                        
  			  end	
      end                                                     		#end of loop - @students_subjects_in_orderedhash.each
  		return true
  end
  #-- end of validation of subject for each student-----18-22 May 2012---------------- 
	
	# retrieve & assign student_id into array - Multiple edit & Multiple new grades
	def self.students_to_array(grades)
		  @studentsA = []
		  grades.each do |grade1|                      												
			  @studentsA << grade1.student_id
		  end
		  return @studentsA 
	end
	
	# retrieve & assign subject_id into array
	def self.subjects_to_array(grades)
		  @subjectidsA = []
 	    grades.each do |grade|
 	        @subjectidsA << grade.subject_id
 	    end
		  return @subjectidsA
	end
	
	#--Return array of duplicate values 
  #--REFERENCE : ref:http://www.dzone.com/snippets/identify-duplicates-array
  #--SAMPLE : for array ['1','2','1'] -> result ["1"]
  #-------------------------------------------------------------------------
  def self.get_quantity_duplicates_subject(subjectids_A)
		  @subjectids_dup = subjectids_A.inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.keys		#--Return array of duplicate values 
      @subjectids_dup_count = @subjectids_dup.count	
	end
	#--Return array of duplicate values for student - Multiple new grades
  #--REFERENCE : ref:http://www.dzone.com/snippets/identify-duplicates-array
  #-------------------------------------------------------------------------
	def self.get_quantity_duplicates_student(studentids_A)
		  @studentids_dup = studentids_A.inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.keys		#--Return array of duplicate values 
      @studentids_dup_count = @studentids_dup.count	
	end
  
  def self.weightage_range_summative
      [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95]
  end
  def self.weightage_range_formative
      [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
  end
  
GRADE = [
  #  Displayed       stored in db
    [ "75% - A","1" ],
    [ "60% - B","2" ],
    [ "55% - C", "3" ],
    [ "35% - D", "4" ],
    [ "<34% - F", "5" ]

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


# code for repeating field score
# ---------------------------------------------------------------------------------

protected
  def examweight_is_compulsory
    errors.add(:examweight, I18n.t('activerecord.errors.messages.must_be_selected')) if examweight.nil? || examweight == 0    
  end
  
  def subject_id_is_compulsory 
    errors.add(:subject_id, I18n.t('activerecord.errors.messages.must_be_selected')) if subject_id.nil? || subject_id == 0
  end

end
