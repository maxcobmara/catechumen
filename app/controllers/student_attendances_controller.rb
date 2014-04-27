class StudentAttendancesController < ApplicationController
  # GET /student_attendances
  # GET /student_attendances.xml
  def index

    submit_val = params[:attendance_search]
    classid = params[:classid]
    @intake_student = params[:intake_student] 
    @programme = params[:programme]
    ######==============
    @programme_list_ids = Programme.at_depth(0).map(&:id)
    @lecturer_programme = current_user.staff.position.unit
    unless @lecturer_programme.nil?
      @programme2 = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme2.nil?
      @preselect_prog= @programme2.id     #@preselect_prog (programme_id)
      @intake_list2 = Student.find(:all, :conditions => ['course_id=?',@preselect_prog], :select=> "DISTINCT intake")
      @topics_ids_this_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id)
    else  #admin
      @intake_list2 = Student.find(:all, :conditions => ['course_id IS NOT NULL and course_id IN(?)',@programme_list_ids], :select=> "DISTINCT intake, course_id",:order=>"course_id,intake") 
      @topics_ids_this_prog = Programme.at_depth(3) 
    end
    @schedule_list = WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?)',@topics_ids_this_prog])
    ######==============
    if submit_val == 'Search Student Attendances'
        @student_attendances = StudentAttendance.search2(classid)
    else
        #@student_attendances = StudentAttendance.search(@intake_student,@programme)
        @student_attendances = StudentAttendance.search(@intake_student,@preselect_prog)
    end
    
    #listing of student attendance
    @student_attendances_class = @student_attendances.group_by{|x|x.weeklytimetable_details_id}
    @student_attendances_intake = @student_attendances.group_by{|x|x.student.intake}
    
    #for ALL existing student attendance
  	@exist_attendances = @student_attendances.map(&:weeklytimetable_details_id).uniq 
  	@exist_timetable_attendances = WeeklytimetableDetail.find(:all, :conditions=>['id IN (?)', @exist_attendances])
    
    #for EDIT multiple by intake & SEARCH by intake
		@intatake = [] 
		@student_attendances_intake.each do |intake, student_attendances|
			 @intatake << intake 
		end 
		@students = @student_attendances.map(&:student_id).uniq 
		@courses = Student.find(@students).map(&:course_id).uniq 
		unless @programme2.nil?                       
	    @intatake2 = Student.find(:all, :conditions => ['course_id=? AND intake IN (?)',@preselect_prog, @intatake], :select=> "DISTINCT intake") 
    else 
      @intatake2 = Student.find(:all, :conditions => ['course_id IN (?) AND intake IN (?)',@courses, @intatake], :select=> "DISTINCT intake,course_id") 
		end 
    
    #yg asal---below this line---
    #@student_attendances = StudentAttendance.all
    #@student_attendances_class = @student_attendances.group_by{|x|x.weeklytimetable_details_id}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @student_attendances }
    end
  end

  # GET /student_attendances/1
  # GET /student_attendances/1.xml
  def show
    @student_attendance = StudentAttendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_attendance }
    end
  end

  # GET /student_attendances/new
  # GET /student_attendances/new.xml
  def new
    #@student_attendance = StudentAttendance.new
    @new_type = params[:new_type]                                                       
	  if @new_type && @new_type == "1"
        @student_attendance = StudentAttendance.new(params[:student_attendance]) 
    elsif @new_type && @new_type == "2"
        @classid = params["classid"]
        @student_attendances = Array.new(5) { StudentAttendance.new } 	        
    elsif @new_type && @new_type == "3"
        @intake = params["intake"]
        @student_attendances = Array.new(5) { StudentAttendance.new }                 
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_attendance }
    end
  end

  # GET /student_attendances/1/edit
  def edit
    @student_attendance = StudentAttendance.find(params[:id])
  end

  # POST /student_attendances
  # POST /student_attendances.xml
  def create
    #raise params.inspect
    @create_type = params[:new_submit]                                            # retrieve - parameter sent via submit button
     if @create_type == "Create"                                                   # create single record 
        @new_type = "1"
        @student_attendance = StudentAttendance.new(params[:student_attendance])
        respond_to do |format|
          if @student_attendance.save
            format.html { redirect_to(@student_attendance, :notice => 'Student attendance was successfully created.') }
            format.xml  { render :xml => @student_attendance, :status => :created, :location => @student_attendance }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @student_attendance.errors, :status => :unprocessable_entity }
          end
        end
        
      elsif @create_type == "Create By Class/Schedule"
 
        @new_type = "2"
        #************************
        @student_attendances_all = params[:student_attendances]  
        @student_attendances = params[:student_attendances].values.collect {|student_attendance| StudentAttendance.new(student_attendance) }
		    
        if @student_attendances.all?(&:valid?) 
          @student_attendances.each(&:save!)                                      # ref: to retrieve each value of @exammarks --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
            flash[:notice] = 'Successfully saved all records'
            redirect_to :action => 'index'
        else                                                                      
			    #@exammarkerrormsg = Exammark.set_error_messages(@exammarks) 
			    #flash[:error] = @exammarkerrormsg	#red box                              
          flash[:error] = 'Data supplied was invalid.'
          render :action => 'new'
          flash.discard
        end
        #************************
        
      elsif @create_type == "Create By Intake"
    #raise params.inspect
        @new_type = "3"
        #************************
        @student_attendances_all = params[:student_attendances]  
        @student_attendances = params[:student_attendances].values.collect {|student_attendance| StudentAttendance.new(student_attendance) }
		    
        if @student_attendances.all?(&:valid?) 
          @student_attendances.each(&:save!)                                      # ref: to retrieve each value of @exammarks --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
            #flash[:notice] = 'Successfully saved all records'
            #params[:student_attendance_ids] = [82,83,84,85,86,87] -testing OK
            params[:student_attendance_ids] = @student_attendances.map(&:id)
            render :action => "edit_multiple_intake"
        else                                                                      
			    #@exammarkerrormsg = Exammark.set_error_messages(@exammarks) 
			    #flash[:error] = @exammarkerrormsg	#red box                              
          flash[:error] = 'Data supplied was invalid.'
          render :action => 'new'
          flash.discard
        end
        #************************
      end
  end

  # PUT /student_attendances/1
  # PUT /student_attendances/1.xml
  def update
    @student_attendance = StudentAttendance.find(params[:id])

    respond_to do |format|
      if @student_attendance.update_attributes(params[:student_attendance])
        format.html { redirect_to(@student_attendance, :notice => 'StudentAttendance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student_attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /student_attendances/1
  # DELETE /student_attendances/1.xml
  def destroy
    @student_attendance = StudentAttendance.find(params[:id])
    @student_attendance.destroy

    respond_to do |format|
      format.html { redirect_to(student_attendances_url) }
      format.xml  { head :ok }
    end
  end


  def edit_multiple_intake
      @edit_type = params[:student_attendance_intake]
      if @edit_type == 'Edit multiple by intake'
          @intake = params[:intake_student]
          @student_attendances_intake = StudentAttendance.all.group_by{|x|x.student.intake.strftime("%Y-%m-%d")}
          @studentattendance_ids = []
          @student_attendances_intake.each do |intake,sa|
              #if intake.strftime("%Y-%m-%d") == '2013-07-01'#@intake
              #if intake == @intake  #"2013-07-01"
                #@studentattendance_ids = [4779, 4780]#sa.map(&:id)
              #els
              if intake == @intake#  "2008-01-01"
                @studentattendance_ids = sa.map(&:id)#[4781,4782,4783,4784,4785,4786]
              end
          end 
         #@studentattendance_ids = [4779, 4780]
         #@studentattendance_ids = [4781,4782,4783,4784,4785,4786]
          #@studentattendance_ids = StudentAttendance#params[:student_attendance_ids]
          unless @studentattendance_ids.blank? 
  	          @studentattendances = StudentAttendance.find(@studentattendance_ids)
  	          @student_count = @studentattendances.map(&:student_id).uniq.count
  	          @edit_type = params[:student_attendance_submit_button]  
          else    
              flash[:notice] = "Please select an intake to edit."+@intake.to_s
              redirect_to student_attendances_path
          end
      end
  end    #--end of multiple edit

  def edit_multiple
    #raise params.inspect
      @studentattendance_ids = params[:student_attendance_ids]
      unless @studentattendance_ids.blank? 
  	      @studentattendances = StudentAttendance.find(@studentattendance_ids)
  	      @studentattendances_group = @studentattendances.group_by{|x|x.student_id} 
  	      
  	      @time_slot_main_count = @studentattendances.group_by{|u|u.weeklytimetable_detail.get_time_slot}.count
        	@studentattendances_group.each do |s,sa|
        		  @time_slot_each_count = sa.group_by{|u|u.weeklytimetable_detail.get_time_slot}.count 
        		  if @time_slot_each_count != @time_slot_main_count
        		      @time_slot_match ="no"
        		  end
        	end
  	      
  	      if ((@studentattendances.count % @studentattendances_group.count) == 0) 
  	          if (@time_slot_match =="no")
  	              flash[:notice] = "Please select student attendances of the same schedule / class."
                  redirect_to student_attendances_path
  	          else
  	              if @time_slot_main_count > 3
  	                  flash[:notice] = "Maximum schedules / classes selection of student attendances for 'Edit by Schedule / Class' is three(3)."
                      redirect_to student_attendances_path
  	              else
  	                  @student_count = @studentattendances.map(&:student_id).uniq.count
  	                  @edit_type = params[:student_attendance_submit_button] 
  	              end
  	          end
  	      else 
  	          flash[:notice] = "Please select complete combination of student attendances for each schedule / class."
              redirect_to student_attendances_path
          end
      else    
          flash[:notice] = "Please select at least 1 record to edit."
          redirect_to student_attendances_path
      end
  end    #--end of multiple edit 
  
  def update_multiple
    #raise params.inspect
      submit_val = params[:applychange]
      @studentattendance_ids = params[:student_attendance_ids]	
      @attends = params[:attends] 
      @reasons = params[:reasons]
      @actions = params[:actions]
      @statuss = params[:statuss]
      @remarks = params[:remarks]
      @weeklytimetable_details_ids = params[:weeklytimetable_details_ids]
      @studentattendances = StudentAttendance.find(@studentattendance_ids)  
      @studentattendances_group = @studentattendances.group_by{|x|x.student_id} 
      
      #####
      if submit_val == 'Apply Schedule / Classes'
          if @weeklytimetable_details_ids != nil
     		      @studentattendances_group.each do |student_id, studentattendances|  
    	            studentattendances.each_with_index do |studentattendance, no|
    	                studentattendance.weeklytimetable_details_id = @weeklytimetable_details_ids[no.to_s]
    	                studentattendance.save
    	            end
    	        end
    	    end

  	      respond_to do |format|
  	          #flash[:notice] = "Updated changes for formative score details!"
  	          format.html {render :action => "edit_multiple_intake"}
      	      flash[:notice] = "<b>Classes/Schedule</b> are selected/updated. You may view/print <b>Attendance Form </b>(c/w date & time slot). <br>To update <b>student attendance</b>, check/uncheck check boxes accordingly and click <b>submit</b>."
      	      format.xml  { head :ok }
      	      flash.discard
  	      end
  	  else
      ##### 
      #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      											 
      #@studentattendances.sort_by{|x|x.student.name}.each_with_index do |student_attendance, index| 
	      #if @attends && @attends[index.to_s]!=nil
	          #student_attendance.attend = true
	      #else
	          #student_attendance.attend = false
	      #end
        #student_attendance.save 
 		  #end	
 		  
 		    #start-for edit_multiple.html.erb--------
 	      if !@weeklytimetable_details_ids
 		        @next2 = 0
 		        @sa_sort_then_group = @studentattendances.sort_by{|y|y.student.name}.group_by{|x|x.student_id} 
			
            @sa_sort_then_group.each do |student_id, studentattendances| 
                studentattendances.sort_by{|u|u.weeklytimetable_detail.get_time_slot}.each_with_index do |studentattendance, no2|
	                  if @attends && @attends[(no2+@next2).to_s]!=nil
	                      studentattendance.attend = true
	                  else
	                      studentattendance.attend = false
	                      if @reasons && @reasons[(no2+@next2).to_s] != nil
	                        studentattendance.reason = @reasons[(no2+@next2).to_s]
	                        studentattendance.action = @actions[(no2+@next2).to_s]
	                        studentattendance.status = @statuss[(no2+@next2).to_s]
	                        studentattendance.remark = @remarks[(no2+@next2).to_s]
	                      end
	                  end
                    studentattendance.save 
                    if no2 == studentattendances.count-1 #2 
							          @next2 = @next2+no2+1 
						        end
                end  
 		        end
 	      end
 		    #end-for edit_multiple.html.erb--------

 		    #start-for edit_multiple_intake.html.erb--------
        @next = 0
     
 		    if @weeklytimetable_details_ids != nil
   		      @studentattendances_group.each do |student_id, studentattendances|  
  	            studentattendances.each_with_index do |studentattendance, no|
  	                studentattendance.weeklytimetable_details_id = @weeklytimetable_details_ids[no.to_s]
  	                if @attends && @attends[(no+@next).to_s]!=nil   #if @attends && @attends[no.to_s]!=nil
              	        studentattendance.attend = true
              	    else
              	      studentattendance.attend = false
              	      end
  	                studentattendance.save 
  	                if no == studentattendances.count-1 #2 
    									 @next = @next+no+1 
    								end 
  	          
  	            end
  	    
  	        end
  	    end
  	    #end-for edit_multiple_intake.html.erb--------
 		    
 		  
 		  flash[:notice] = "Updated student attendance!"
  	  redirect_to student_attendances_path
  	  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	    end
  	  
  	  
  end   			#--end of def update_multiple
   
  def borang_kehadiran
      @studentattendance_ids = params[:iddd]    #[628,629,630,631,632,633]
      @first = params[:first].to_i
      @form_type = params[:form_type]
      @student_attendances = StudentAttendance.find(:all, :conditions => ['id IN (?)',@studentattendance_ids])
      
      if (@student_attendances[0].weeklytimetable_details_id != nil) && (@student_attendances[@student_attendances.count-1].weeklytimetable_details_id != nil)
          @student_attendances = @student_attendances.sort_by{|u|u.weeklytimetable_detail.day_time_slot}
      elsif (@student_attendances[0].weeklytimetable_details_id != nil) && (@student_attendances[@student_attendances.count-1].weeklytimetable_details_id == nil)
          @student_attendancesA = StudentAttendance.find(:all, :conditions => ['id IN (?) AND weeklytimetable_details_id IS NOT NULL',@studentattendance_ids]).sort_by{|u|u.weeklytimetable_detail.day_time_slot}
          @student_attendancesB = StudentAttendance.find(:all, :conditions => ['id IN (?) AND weeklytimetable_details_id IS NULL',@studentattendance_ids])
          @student_attendances = @student_attendancesA+@student_attendancesB
      end
      #@student_attendances = StudentAttendance.find(:all, :conditions => ['id IN (?)',@studentattendance_ids]).sort_by{|u|u.weeklytimetable_detail.get_time_slot}
      @studentattendances_group = @student_attendances.sort_by{|x|x.student.name}.group_by{|x|x.student_id} #sort first than group!
      render :layout => 'report'
  end
  

   
end
