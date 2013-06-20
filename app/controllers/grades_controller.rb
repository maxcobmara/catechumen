class GradesController < ApplicationController
  # GET /grades
  # GET /grades.xml
  def index
    submit_val = params[:grade_search]
    subjectid = params[:subject_id]
    @grades = Grade.search2(subjectid)
    @grades_group = @grades.group_by{|x|x.subject_id}
    
    #@grades = Grade.all
    #@grades_group = @grades.group_by{|x|x.subject_id}
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grades }
    end
  end

  # GET /grades/1
  # GET /grades/1.xml
  def show
    @grade = Grade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grade }
    end
  end

  # GET /grades/new
  # GET /grades/new.xml
  def new
    #raise params.inspect
    #@new_type = params[:new_type]                                                       # retrieve - parameter sent via link_to
	  #@new_type = params[:new_type]  
    submit_val = params[:submit_button1]      
    @new_type = "0" if submit_val == "Single New Grade"    
    @new_type = "3" if submit_val == "Multiple New Grades"                              # retrieve - parameter sent via link_to
	  if @new_type && @new_type == "1"                                                    # multiple new records
		  @grades = Array.new(1) { Grade.new } 	#(params[:grades])
		  @grades.each do |grade|                                                           # have to build nested attribute, score(formative) inside of each item of grade array
		    grade.scores.build
      end
    elsif @new_type && @new_type =="0"                                                  # one new record
	    #@subject_id = params[:subjectid]    #use @subject_id here
	    #@grade = Grade.new(params[:grade]) 
	    #@grade.scores.build
	    ##===============use below instead...better, if there's grade of the same subject already exist 
	    #-> set formative score accordingly..reference:10Jun2013-BIG problem folder
      @subject_id = params[:subjectid]                                                #retrieve subject_id from index page
      unless @subject_id.blank? 
          @grade = Grade.new(params[:grade]) 
          @grade_subject = Grade.find(:first, :conditions=>['subject_id IN (?)', @subject_id])
          if @grade_subject 
              @grade_weightage = @grade_subject.examweight
              @grade_scores = @grade_subject.scores
              @score_count = @grade_scores.count if @grade_scores
              if @score_count>0
                  0.upto(@score_count-1) do |c|
  	                  @grade.scores.build
  	                  @grade.scores[c].type_id = @grade_scores[c].type_id         
  	                  @grade.scores[c].description = @grade_scores[c].description 
  	                  @grade.scores[c].weightage = @grade_scores[c].weightage
  	              end
  	          else
  	              @grade.scores.build   
  	          end
  	      else
              @grade.scores.build       
          end
      end
      ##===============
	  #3June2013
    elsif @new_type && @new_type == "3"
      @subjectid = params[:subjectid]     #use @subjectid here 
      @grades = Array.new(1) { Grade.new } 	#(params[:grades])
     	@grades.each do |grade|                                                           # have to build nested attribute, score(formative) inside of each item of grade array
     		  grade.scores.build
      end
      #@exammarks = Array.new(5) { Exammark.new } 	                              #(params[:exammarks])
      #@exammarks.each do |exammark|                                                         # have to build nested attribute, mark(formative) inside of each item of grade array
        	#exammark.marks.build          
      #end
    #13June2013
	  end  
    
    #@grade = Grade.new
    #@grade.scores.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grade }
    end
  end

  # GET /grades/1/edit
  def edit
    @grade = Grade.find(params[:id])
  end

  # POST /grades
  # POST /grades.xml
  def create
    @create_type = params[:new_submit]            #3June2013
    if @create_type == "Create"   
        @new_type ="0"                            # Assign same value as defined value in new action (:new_type value for 'New grade' link in index page!)
        @grade = Grade.new(params[:grade]) 
        @grades_all = params[:grades]     
        respond_to do |format|
            if @grade.save
                flash[:notice] = 'Grade was successfully created.'
                format.html { redirect_to(@grade) }
                format.xml  { render :xml => @grade, :status => :created, :location => @grade }
            else
                format.html { render :new }                                      
                format.xml  { render :xml => @grade.errors, :status => :unprocessable_entity }
            end
        end   # end of respond_to do block
    
    elsif @create_type == "Create By Subject"
        #raise params.inspect
        @new_type = "2"
        @subjectid = params[:subjectid]  
        #************************
        #@exammarks_all = params[:exammarks]  
        @grades_all = params[:grades]  
        #@exammarks = params[:exammarks].values.collect { |exammark| Exammark.new(exammark) }
        @grades = params[:grades].values.collect { |grade| Grade.new(grade) }
	    
	      #---start-retrieve params value of entered data by user - for action:new usage --> when errors arrise & requires re-submission of form 
		    #@exammaker_id = Exammark.set_params_value(@exammarks,0)
		    #@selected_subject = Exammaker.find(@exammaker_id).subject_id
		    #@examquestions = Exammaker.find(@exammaker_id).examquestions
		    #@students = Student.available_students2(@selected_subject) 
		    #@students_qty = @students.count
		    #----end-retrieve params value of entered data by user - for action:new usage --> when errors arrise & requires re-submission of form 
	    
	      #---this part will assign & save total marks (of exammaker[exam paper]) taken directly to grade table - field exam1marks)
        #@all_exammarks = params[:exammarks]
        @all_grades = params[:grades]
        #Exammark.update_multiple_exam1mark_in_grades(@exammaker_id,@all_exammarks,@selected_subject,@students)
        #---where exam1marks field (grade table) loaded with total marks & saved in db-------------------------------------------
      
        if @grades.all?(&:valid?) 
            @grades.each(&:save!)                                      # ref: to retrieve each value of @exammarks --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
            flash[:notice] = 'Grades are successfully created'
            redirect_to :action => 'index' 
            #flash.discard
            
             
              
        else                                  
            #@exammarkerrormsg = Exammark.set_error_messages(@exammarks) 
		        #@gradeerrormsg = Exammark.set_error_messages(@grades) 
		        @gradeerrormsg = Grade.set_error_messages(@grades) 
		        @new_type = "3"
		        #flash[:error] = @exammarkerrormsg	#red box  
		        flash[:error] = @gradeerrormsg	#red box      
		        flash[:notice] = 'Data supplied was invalid.'                        
            #flash[:notice] = 'Data supplied was invalid. Please insert all data accordingly. All fields are compulsory.'
            render :action => 'new'
            
            flash.discard
        end
        #************************
    end
    
  end

  # PUT /grades/1
  # PUT /grades/1.xml
  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        flash[:notice] = 'Grade was successfully updated.'
        format.html { redirect_to(@grade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.xml
  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy

    respond_to do |format|
      format.html { redirect_to(grades_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_subject
    @programme_id = params[:programmeid]
    unless @programme_id.blank? 
      #@subjects = Subject.find(:all, :joins => :programmes,:conditions => ['programme_id=?', @programme_id])
      @subjects = Programme.find(@programme_id).descendants.at_depth(2)
    end
    render :partial => 'view_subject', :layout => false
  end
  
  def view_intake
    @subject_id = params[:subjectid]
    unless @subject_id.blank?
        @semester = Programme.find(@subject_id).parent.code
        @current_year = Date.today.year
        @current_month = Date.today.month
        @intake_list = Student.find(:all,:conditions=> ['course_id=?',Programme.find(@subject_id).root.id]).group_by{|l|l.intake}
       # @intake_list = Student.find(:all,:conditions=> ['course_id=?',@programmeid]).group_by{|l|l.intake}
        @iii=Exammark.set_intake_group(@current_year,@current_month,@semester).to_s  #refer exammark/_form_multiple_intake.html.erb
    end
    render :partial => 'view_intake', :layout => false
  end
  
  #3June2013
  def view_grades_form_multiple_subject
    #@exam_id = params[:examid]  
    @subject_id = params[:subjectid]      
    @intake_id = params[:intakeid]
    @programme_id= params[:programmeid]
    
    #unless @exam_id.blank? || @exam_id.nil? 
    unless @subject_id.blank? || @subject_id.nil? 
       #@examquestions = Exam.find(@exam_id).examquestions
       unless @intake_id.blank? || @intake_id.nil? 
         @students = Student.find(:all, :conditions=>['course_id=? and intake=?',@programme_id,@intake_id.to_s])
       end
       ##@students = Student.find(:all, :conditions=>['course_id=? and intake=? and gender=?',3,'2011-07-01',1])
       #below-fr form_multiple_subject
       @grade_exist_subject_student=Grade.find(:all, :conditions => ['subject_id=? AND student_id IN(?)',@subject_id, @students.map(&:id)]).count
       
    end
    
    render :partial => 'view_grades_form_multiple_subject', :layout => false
  end
  #3June2013
  
  def update_summative_weightage
    @weightage = params[:weightage]
    @intake_id = params[:intakeid]
    @programme_id= params[:programmeid]
    @modify = params[:modify]
    @exist_ids = params[:existstudents_id]
    @subjectid = params[:subjectid]
    @formative_qty = params[:formativeqty]
    @formative_type0 = params[:formativetype0]
    @formative_type1 = params[:formativetype1]
    @formative_type2 = params[:formativetype2]
    @formative_type3 = params[:formativetype3]
    @formative_type4 = params[:formativetype4]
    @formative_type5 = params[:formativetype5]
    @formative_weight0 = params[:formativeweight0]
    @formative_weight1 = params[:formativeweight1]
    @formative_weight2 = params[:formativeweight2]
    @formative_weight3 = params[:formativeweight3]
    @formative_weight4 = params[:formativeweight4]
    @formative_weight5 = params[:formativeweight5]
    @formative_desc0 =params[:formativedesc0]
    @formative_desc1 =params[:formativedesc1]
    @formative_desc2 =params[:formativedesc2]
    @formative_desc3 =params[:formativedesc3]
    @formative_desc4 =params[:formativedesc4]
    @formative_desc5 =params[:formativedesc5]

    @students = Student.find(:all, :conditions=>['course_id=? and intake=?',@programme_id,@intake_id.to_s])
    @students_count = @students.count 
		
    render :partial => 'update_weightage', :layout => false
  end
  
  def update_formative_scores
    @formative_qty = params[:formativeqty]
    render :partial => 'update_formative', :layout => false
  end
  
  #--start of multiple edit - 3 June 2013 ----------------------------
  def edit_multiple
    #raise params.inspect
    @gradeids = params[:grade_ids]
    unless @gradeids.blank? 
 	    @grades = Grade.find(@gradeids).sort_by{|x|x.studentgrade.name} #@grades = Grade.find(@gradeids)
 	    @edit_type = params[:grade_submit_button]
		    if @edit_type == "Edit Checked"
 	        ## continue multiple edit (including subject edit here) --> refer view
       end    # end for if @edit_type=="Edit Checked"
    else    # else for unless @gradeids.blank?
        flash[:notice] = "Please select at least 1 record to edit."
        redirect_to exammarks_path
    end			# end for unless @gradeids.blank?
  end
  #--end of multiple edit - 3 June 2013----------------------------
  
   #--start of multiple updates - 3 June 2013 ----------------------------
   def update_multiple
     #raise params.inspect
     submit_val = params[:applychange]
     #@exammarksid = params[:exammark_ids]	
     @gradesid = params[:grade_ids]
     #@totalmcqs =params[:total_mcqs]     
     @formatives = params[:formatives]  
     @caplusmse = params[:scores]
     @examweights = params[:examweights]  
     if @subjects_of_grades==1 || submit_val == 'Apply Changes'
        @summative_weightage = params[:grade][:summative_weightage]    
        @scores = params[:scores_attributes]
        @scores_new_count = @scores.count 
     end
     @scores1 = params[:scores] #caplusmse
     @exam1markss = params[:exam1markss]
     @summatives = params[:summatives]
     @finalscores = params[:finalscores]                             
     @senttobpls = params[:sent_to_BPLs]                    # "sent_to_BPLs"=>{"2"=>"true"}, "sent_to_BPLs"=>{"1"=>"true","2"=>"true"}	  
 	   @eligibleexams = params[:eligible_for_exams]
 	   @carrypapers = params[:carry_papers] 
 	   @resits = params[:resits]
 	   @grades = Grade.find(@gradesid)	             											 
     
     if submit_val == 'Apply Changes'
        @grades.sort_by{|x|x.studentgrade.name}.each_with_index do |grade, index| 
            0.upto(grade.scores.count-1) do |score_count|
                #Please note : use this : params[:scores_attributes][score_count.to_s][:type_id] INSTEAD OF this:params[:scores_attributes][score_count.to_s][:type_id][index]
                grade.scores[score_count].type_id = params[:scores_attributes][score_count.to_s][:type_id]
	              grade.scores[score_count].description = params[:scores_attributes][score_count.to_s][:description]# "AAA"
	              grade.scores[score_count].weightage = params[:scores_attributes][score_count.to_s][:weightage]
	          end
	          grade.examweight = @summative_weightage 
	          grade.save
	      end
	      #------------------------------------------------remove if error again!!-------------------------------------
	      @grades.sort_by{|x|x.studentgrade.name}.each_with_index do |grade, index|  
	          (grade.scores.count).upto(@scores_new_count-1) do |c|
	              grade.scores.build
                grade.scores[c].type_id = params[:scores_attributes][c.to_s][:type_id]#@grade_scores[2].type_id         
                grade.scores[c].description = params[:scores_attributes][c.to_s][:description]#@grade_scores[2].description 
                grade.scores[c].weightage = params[:scores_attributes][c.to_s][:weightage]#@grade_scores[2].weightage
	              grade.scores[c].marks = 0
	              grade.examweight = @summative_weightage 
	              ##grade.save
	          end
	          grade.save
	      end
	      #------------------------------------------------remove if error again!!-------------------------------------
	      respond_to do |format|
	          #flash[:notice] = "Updated changes for formative score details!"
	          format.html {render :action => "edit_multiple"}
    	      flash[:notice] = "<b>Formative Score variables</b> and <b>Summative Weightage</b> are updated. <b>Please EDIT marks accordingly</b>."
    	      format.xml  { head :ok }
    	      flash.discard
	      end
     else   
        #below (add-in sort_by) in order to get data match accordingly to form values (sorted by student name)
        @grades.sort_by{|x|x.studentgrade.name}.each_with_index do |grade, index| #amended-2June2012-prev:#@exammarks.each_with_index do |exammark,index|
 		        #exammark.total_mcq = @totalmcqs[index]
 		        grade.formative = @formatives[index]
 		        grade.score = @caplusmse[index]
 		        if @examweights
 		          grade.examweight = @examweights[0] if @examweights.count==1       #for selected grades with different subject
 		          grade.examweight = @examweights[index] if @examweights.count>1
 		        end
 		                                   #for selected grades with same subject
 			      #0.upto(exammark.marks.count-1) do |cc|
 			          #exammark.marks[cc].student_mark = params[:marks_attributes][cc.to_s][:student_marks][index]
 			      #end
 			      #---BIG PROBLEM-SAVE SCORE TABLE SEPARATELY - RESOLVE..TEMPORARY-10JUN2013-AM-START-replace grades.score... with y.marks...
 			      scores_of_grades = Score.find(:all, :conditions => ['grade_id=?',grade.id])
 			      scores_of_grades.sort_by{|x|x.created_at}.each_with_index do |y,no| #tak boleh by created_at?
 			      #scores_of_grades.each_with_index do |y,no| #tak boleh by created_at?
 			        y.marks = params[:scores_attributes][no.to_s][:marks][index]
 			        y.save
 			      end
 			      #0.upto(grade.scores.count-1) do |score_count|
	            #grade.scores[score_count].marks = params[:scores_attributes][score_count.to_s][:marks][index]
	          #end
 			      #grade.score=params[:scores_attributes]["1"][:marks][index]#@scores1[index] 
 			      #---BIG PROBLEM-SAVE SCORE TABLE SEPARATELY - RESOLVE..TEMPORARY-10JUN2013-AM-END------------------------------------------
 			      
 			      grade.exam1marks=@exam1markss[index]
 			      grade.summative=@summatives[index]
 			      grade.finalscore=@finalscores[index]
 			      if @subjects_of_grades==1 
 			          grade.examweight = @summative_weightage 
 			          #--BIG PROBLEM-remove to line 331 but yet replace with direct SAVING DATA INTO SCORES table instead of grades.scores...
 			          #0.upto(grade.scores.count-1) do |score_count|
 			            #grade.scores[score_count].marks = params[:scores_attributes][score_count.to_s][:marks][index]
 			          #end
 			          #--end of BIG PROBLEM
 			      end 
 			      #exammark.save
 			      #--assign checkbox value-sent_to_BPL-----
 			      if @senttobpls && @senttobpls[index.to_s]!=nil
 			          grade.sent_to_BPL = true
 			      else
 			          grade.sent_to_BPL = false
 			      end
 			      #--asign checkbox value------
 			      #--assign checkbox value-eligible_for_exam----
 			      if @eligibleexams && @eligibleexams[index.to_s]!=nil
 			          grade.eligible_for_exam = true
 			      else
 			          grade.eligible_for_exam = false
 			      end
 			      #--asign checkbox value------
 			      #--assign checkbox value-carry paper----
 			      if @carrypapers &&@carrypapers[index.to_s]!=nil
 			          grade.carry_paper = true
 			      else
 			          grade.carry_paper = false
 			      end
 			      #--asign checkbox value------
 			      #--assign checkbox value-resit----
 			      if @resits && @resits[index.to_s]!=nil
 			          grade.resit = true
 			      else
 			          grade.resit = false
 			      end
 			      #--asign checkbox value------
 			      grade.save
 		    end			#--end of @grades.each_with_index do |grade,index|--
 		  
 		    flash[:notice] = "Updated grades!"
  	    #redirect_to exammarks_path
  	    redirect_to grades_path
  	  end
  	    
   end   			#--end of def update_multiple
   #--end of multiple edit - 3 June 2013 ----------------------------
   def form_try
     @nombor = params[:index]
     render :layout => false
   end
end
