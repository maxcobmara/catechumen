class ExammarksController < ApplicationController
  # GET /exammarks
  # GET /exammarks.xml
  def index
    submit_val = params[:exammark_search]
    @position_exist = current_login.staff.position
    if @position_exist     
      @lecturer_programme = current_login.staff.position.unit
      common_subject = Programme.find(:all, :conditions=>['course_type=?','Commonsubject']).map(&:id)
      unless @lecturer_programme.nil?
        @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
      end
      unless @programme.nil?
        @programme_id = @programme.id
        subject_of_programme = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
        @exam_list_index = Exam.find(:all, :conditions=>['subject_id IN(?) AND subject_id NOT IN(?)',subject_of_programme, common_subject])
        #@exam_list_exist_mark = Exammark.find(:all, :conditions=>['exam_id IN(?)', @exam_list_index.map(&:id)])                        #exammarks
        @exam_list_exist_mark = Exam.find(:all, :joins=>:exammarks, :conditions => ['exam_id IN(?)', @exam_list_index.map(&:id)]).uniq  #exam
      else
        if @lecturer_programme == 'Commonsubject'
          @exam_list_index = Exam.find(:all, :conditions=>['subject_id IN(?)', common_subject])
          @exam_list_exist_mark = Exam.find(:all, :joins=>:exammarks, :conditions => ['exam_id IN(?)', @exam_list_index.map(&:id)]).uniq    
        else
          @exam_list_index = Exam.all
          @exam_list_exist_mark = Exam.find(:all, :joins=>:exammarks).uniq
        end
      end
      if submit_val == 'Search Exam Marks'
        search_item = params[:exam_id]
        if search_item == '0' 
          exam_ids = @exam_list_exist_mark.map(&:id)  
        else  
          exam_ids = Array(search_item)  
        end
      else
        exam_ids = @exam_list_exist_mark.map(&:id)
      end
    
      @exammarks = Exammark.search2(exam_ids)
      @exammarks_group = @exammarks.group_by{|x|x.exam_id}
    end  
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exammarks }
    end
  end

  # GET /exammarks/1
  # GET /exammarks/1.xml
  def show
    @exammark = Exammark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exammark }
    end
  end

  # GET /exammarks/new
  # GET /exammarks/new.xml
  def new
    @new_type = params[:new_type]                                                       
	  if @new_type && @new_type == "1"
        #===========
        @exammark = Exammark.new(params[:exammark]) 
        @exammark.marks.build
        #===========
    elsif @new_type && @new_type == "2"
        #-----------
        @exammarks = Array.new(5) { Exammark.new } 	                              #(params[:exammarks])
    		@exammarks.each do |exammark|                                                         # have to build nested attribute, mark(formative) inside of each item of grade array
    				exammark.marks.build          
    		end
        #-----------
    #14Apr2013
    elsif @new_type && @new_type == "3"
         @examid = params["examid"]
         @exammarks = Array.new(5) { Exammark.new } 	                              #(params[:exammarks])
      	 @exammarks.each do |exammark|                                                         # have to build nested attribute, mark(formative) inside of each item of grade array
      			exammark.marks.build          
      	 end
    #14Apr2013
    end
    
    ###--to do LATER---start----##### (part 1-ref:24 April 2014) 
    #new multiple marks
    #1st time - new multiple exammarks :
    #sample - intake 1/3/2013, kebidanan - mid sem on 24/5/2013, final on 24/8/2013 - (BOTH) - 1st time created OK
    #2nd time - new multiple exammarks :
    #ok : (1) intake 1/3/2013 - kebidanan - mid sem 24/5/2013 - error : already exist (CORRECT)
    #TO DO : (2) intake 1/9/2013 - kebidanan - mid sem 24/5/2013 - error : already exist (WRONG) - EXPECTED error : intake date > exam date(@ hide terus)
    #ok : (1) intake 1/3/2013 - kebidanan - final 24/8/2013 - error : already exist (CORRECT)
    #TO DO : (2) intake 1/9/2013 - kebidanan - final 24/8/2013 - no error (WRONG) - EXPECTED error : intake date > exam date (@ hide terus)
    ###--to do LATER---end----#######
    ###--to do LATER---start---##### (part 2-ref:24 April 2014)
    #login as Commonsubject lecturer - can view all Commonsubject exampapers (exam/exammaker)
    #new multiple marks
    #intake listing should be based on student intake of selected exampaper, 
    #eg. exampaper for Commonsubject (of POSBASIK kebidanan) - student INTAKE should be among Kebidanan Intake ONLY, not other programme INTAKE
    #pls note - Kebidanan - intake March & Sept while the rest - intake Jan & July - upon selection of exampaper(Commonsubject), should already know 
    #..Commonsubject goes under which programme? -> refer @dept_unit_prog value for guidance (note - @examid).
    ###--to do LATER---end----####### 
    
    ###--just amended
    @lecturer_programme = current_login.staff.position.unit
    common_subject = Programme.find(:all, :conditions=>['course_type=?','Commonsubject']).map(&:id)
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_id = @programme.id
      subject_of_programme = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
      @exam_list = Exam.find(:all, :conditions=>['subject_id IN(?) AND subject_id NOT IN(?)',subject_of_programme, common_subject])
      @student_list = Student.find(:all,:conditions=>['course_id=?', @programme.id], :order=>'name ASC')
      @dept_unit_prog = @lecturer_programme   #form_multiple_intake, line 98
      @intake_list = @student_list.group_by{|l|l.intake}
    else
      if @lecturer_programme == 'Commonsubject'
        @exam_list = Exam.find(:all, :conditions=>['subject_id IN(?)', common_subject])
        @student_list = Student.all 
      else
        @exam_list = Exam.all
        @student_list = Student.all
      end
      #for administrator & Commonsubject lecturer : to assign programme, based on selected exampaper 
      @dept_unit = Programme.find(Exam.find(@examid).subject_id).root
      @dept_unit_prog = @dept_unit.name   #form_multiple_intake, line 98
      @intake_list = Student.find(:all, :conditions=>['course_id=?',@dept_unit.id]).group_by{|l|l.intake}
    end
    arr = []
    @intakes = @intake_list.each {|i,k| arr<<i}   #form_multiple_intake, line 128
    ###--just amended
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exammark }
    end
  end

  # GET /exammarks/1/edit
  def edit
    @exammark = Exammark.find(params[:id])
    ###--just amended
    @lecturer_programme = current_login.staff.position.unit
    common_subject = Programme.find(:all, :conditions=>['course_type=?','Commonsubject']).map(&:id)
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_id = @programme.id
      subject_of_programme = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
      @exam_list = Exam.find(:all, :conditions=>['subject_id IN(?) AND subject_id NOT IN(?)',subject_of_programme, common_subject])
      @student_list = Student.find(:all,:conditions=>['course_id=?', @programme.id], :order=>'name ASC')
    else
      if @lecturer_programme == 'Commonsubject'
        @exam_list = Exam.find(:all, :conditions=>['subject_id IN(?)', common_subject])
        @student_list = Student.all  
      else
        @exam_list = Exam.all
        @student_list = Student.all
      end
    end
    ###--just amended
  end

  # POST /exammarks
  # POST /exammarks.xml
  def create
     @create_type = params[:new_submit]                                            # retrieve - parameter sent via submit button
     if @create_type == "Create"                                                   # create single record 
        @new_type = "1"
        #========================
        @exammark = Exammark.new(params[:exammark])
        #---this part will assign & save total marks (of exammaker[exam paper]) taken directly to grade table - field exam1marks)
        #@exammaker_id = params[:exammark][:exammaker_id]
        #@student_id = params[:exammark][:student_id]
        #@all_marks= params[:exammark][:marks_attributes]
        #Exammark.update_single_exam1mark_in_grades(@exammaker_id,@student_id,@all_marks)
        #---exam1marks field (grade table) loaded with total marks & saved in db-------------------------------------------------
        #========================
        
        respond_to do |format|
          if @exammark.save
            format.html { redirect_to(@exammark, :notice => 'Exammark was successfully created.') }
            format.xml  { render :xml => @exammark, :status => :created, :location => @exammark }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @exammark.errors, :status => :unprocessable_entity }
          end
        end
        
      elsif @create_type == "Create By Paper"
        #raise params.inspect
        @new_type = "2"
        #************************
        @exammarks_all = params[:exammarks]  
        @exammarks = params[:exammarks].values.collect { |exammark| Exammark.new(exammark) }
		    
		    #---start-retrieve params value of entered data by user - for action:new usage --> when errors arrise & requires re-submission of form 
			  #@exammaker_id = Exammark.set_params_value(@exammarks,0)
			  #@selected_subject = Exammaker.find(@exammaker_id).subject_id
			  #@examquestions = Exammaker.find(@exammaker_id).examquestions
			  #@students = Student.available_students2(@selected_subject) 
			  #@students_qty = @students.count
			  #----end-retrieve params value of entered data by user - for action:new usage --> when errors arrise & requires re-submission of form 
		    
		    #---this part will assign & save total marks (of exammaker[exam paper]) taken directly to grade table - field exam1marks)
        @all_exammarks = params[:exammarks]
        #Exammark.update_multiple_exam1mark_in_grades(@exammaker_id,@all_exammarks,@selected_subject,@students)
        #---where exam1marks field (grade table) loaded with total marks & saved in db-------------------------------------------
        
        if @exammarks.all?(&:valid?) 
          @exammarks.each(&:save!)                                      # ref: to retrieve each value of @exammarks --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
            flash[:notice] = 'Successfully saved all records'
            redirect_to :action => 'index'
            flash.discard
        else                                                                      
			    @exammarkerrormsg = Exammark.set_error_messages(@exammarks) 
			    flash[:error] = @exammarkerrormsg	#red box                              
          flash[:notice] = 'Data supplied was invalid. Please insert all data accordingly. All fields are compulsory.'
          render :action => 'new'
          flash.discard
        end
        #************************
      end
      
    
  end

  # PUT /exammarks/1
  # PUT /exammarks/1.xml
  def update
    #raise params.inspect
    @exammark = Exammark.find(params[:id])
    @exammark.total_mcq = params[:exammark][:total_mcq] #5June2013-added refer exammark.rb(set_total_mcq) & _view_marks_form.html.erb 
    #---
    ###
     #@totalmarks_in_grade = 0
		 #@exammark.marks.sort_by{|x|x.created_at}.each_with_index do |aa, cc|
		      #aa.student_mark = params[:marks_attributes][cc.to_s][:student_marks][index]
		      #@totalmarks_in_grade += (params[:exammark][:marks_attributes][cc.to_s][:student_marks][index]).to_f
		  #end
    ###
     
     #@credit_hour=Programme.find(@exammark.exampaper.subject.id).credits.to_i
	    #@grade_to_update = Grade.find(:first, :conditions=>['student_id =? and subject_id=?', @exammark.student_id,@exammark.exampaper.subject.id])
	    #if @grade_to_update && @credit_hour 
	      #if @credit_hour == 3
	       # @grade_to_update.exam1marks = (@totalmarks_in_grade+@exammark.total_mcq.to_f)/0.9
	       # @grade_to_update.summative = (@totalmarks_in_grade+@exammark.total_mcq.to_f)/0.9*0.7
        #elsif @credit_hour == 4
         # @grade_to_update.exam1marks = (@totalmarks_in_grade+@exammark.total_mcq.to_f)/1.2
         # @grade_to_update.summative = (@totalmarks_in_grade+@exammark.total_mcq.to_f)/1.2*0.7
        #elsif @credit_hour == 2
         # @grade_to_update.exam1marks = (@totalmarks_in_grade+@exammark.total_mcq.to_f)/0.7
         # @grade_to_update.summative = (@totalmarks_in_grade+@exammark.total_mcq.to_f)/0.7*0.7
       # else
        #  @grade_to_update.exam1marks = @totalmarks_in_grade+@exammark.total_mcq.to_f
        #  @grade_to_update.summative = (@totalmarks_in_grade+@exammark.total_mcq.to_f)*0.7
      #  end
       # @grade_to_update.save
    #  end
    #---
    respond_to do |format|
      if @exammark.update_attributes(params[:exammark])
        format.html { redirect_to(@exammark, :notice => 'Exammark was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exammark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exammarks/1
  # DELETE /exammarks/1.xml
  def destroy
    @exammark = Exammark.find(params[:id])
    @exammark.destroy

    respond_to do |format|
      format.html { redirect_to(exammarks_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_marks_form

      @exam_id = params[:examid]
      unless @exam_id.blank? 
        @examquestions = Exam.find(@exam_id).examquestions
      end
      render :partial => 'view_marks_form', :layout => false

    
  end
  
  #start-NOT IN USE---
  #-----start-for multiple new entry-filter by programme----12,17-18 Sept 2012-----copy codes from examresults_controller.rb
   def view_marks_form_multiple
     @exam_id = params[:examid]    #Refers to label:subject 

     unless @exam_id.blank? || @exam_id.nil? 
       @examquestions = Exam.find(@exam_id).examquestions
       #@subject = Exammaker.find(@exammaker_id).subject_id
       #@students = Student.available_students2(@subject) 
       @students = Student.find(:all, :conditions=>['course_id=? and intake=? and gender=?',3,'2011-07-01',1])
     end
     render :partial => 'view_marks_form_multiple', :layout => false   

   end
   #-----end-for multiple new entry-filter by programme----12,17-18 Sept 2012-----
   #end-NOT IN USE---
   
   #14Apr2013
   def view_marks_form_multiple_intake
     @exam_id = params[:examid]    
     @intake_id = params[:intakeid]
     @programme_id= params[:programmeid]
    
      unless @exam_id.blank? || @exam_id.nil? 
        @examquestions = Exam.find(@exam_id).examquestions
        @students = Student.find(:all, :conditions=>['course_id=? and intake=?',@programme_id,@intake_id.to_s])
        #@students = Student.find(:all, :conditions=>['course_id=? and intake=? and gender=?',3,'2011-07-01',1])
        @studentscount = @students.count  #NEWLY ADDED
        @exammark_exist_for_exam=Exammark.find(:all, :conditions => ['exam_id=? AND student_id IN(?)',@exam_id, @students.map(&:id)]).count ##NEWLY ADDED
        @istemplate = Exam.find(@exam_id).klass_id
        @examtemplates = Exam.find(@exam_id).examtemplates
        @qty_ary = @examtemplates.map(&:quantity) ##NEW ADDED
        @questioncount = @qty_ary.inject{|sum,x|sum+x} #@questioncount=0
				#@examtemplates.each do |examtemplate| 
						#@questioncount+= examtemplate.quantity 
				#end
        
      end
      render :partial => 'view_marks_form_multiple_intake', :layout => false
      #@@@@@@@@@@@@@@@@@@@@@@@@
      			
      
      #@@@@@@@@@@@@@@@@@@@@@@@@
   end
   #14Apr2013
   
   
   #--start of multiple edit - 15-18, 27 May 2012 ----------------------------
   def edit_multiple
     #raise params.inspect
     @exammarkids = params[:exammark_ids]
     unless @exammarkids.blank? 
  	    @exammarks = Exammark.find(@exammarkids)
  	    @student_count = @exammarks.map(&:student_id).uniq.count
  	    @edit_type = params[:exammark_submit_button]
 		    if @edit_type == "Edit Checked"
  	        ## continue multiple edit (including subject edit here) --> refer view
        end    # end for if @edit_type=="Edit Checked"
     else    # else for unless @gradeids.blank?
         flash[:notice] = "Please select at least 1 record to edit."
         redirect_to exammarks_path
     end			# end for unless @gradeids.blank?
   end
   #--end of multiple edit - 15-18, 27 May 2012 ----------------------------
   
   #--start of multiple updates - 15-18, 27 May 2012 ----------------------------
   def update_multiple
     #raise params.inspect
     @exammarksid = params[:exammark_ids]	
     @totalmcqs =params[:total_mcqs]                                          
     @marks = params[:marks_attributes]
 	   @exammarks = Exammark.find(@exammarksid)	              											 
     
     #below (add-in sort_by) in order to get data match accordingly to form values (sorted by student name)
     @exammarks.sort_by{|x|x.studentmark.name}.each_with_index do |exammark, index| #amended-2June2012-prev:#@exammarks.each_with_index do |exammark,index|
 		    exammark.total_mcq = @totalmcqs[index]
 			  #0.upto(exammark.marks.count-1) do |cc|
 			  #rescue for 1st time entry--
 			  totalmarks_in_grade = 0
 			  #rescue for 1st time entry--
 			  exammark.marks.sort_by{|x|x.created_at}.each_with_index do |aa, cc|
 			        aa.student_mark = params[:marks_attributes][cc.to_s][:student_marks][index]
 			        totalmarks_in_grade += (params[:marks_attributes][cc.to_s][:student_marks][index]).to_f     #added on 16june2013-am
 			        #exammark.marks[cc].student_mark = params[:marks_attributes][cc.to_s][:student_marks][index]
 			        #--remove later-16Apr2013--
 			        #if cc==0
 			          #exammark.marks[cc].student_mark = params[:marks_attributes][cc.to_s][:student_marks][index]
 			        #elsif cc==1
 			          #exammark.marks[cc].student_mark = 32
 			        #elsif cc==2
 			          #exammark.marks[cc].student_mark = 33
 			        #end 
 			        #--remove later-16Apr2013--
 			  end
 			  exammark.save 
 			 
 		  end			#--end of @grades.each_with_index do |grade,index|--
 		  
 		  flash[:notice] = "Updated exam marks!"
  	  redirect_to exammarks_path
   end   			#--end of def update_multiple
   #--end of multiple edit - 15-18 May 2012 ----------------------------
end
