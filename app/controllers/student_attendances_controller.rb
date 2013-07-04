class StudentAttendancesController < ApplicationController
  # GET /student_attendances
  # GET /student_attendances.xml
  def index
    ##
    submit_val = params[:exammark_search]
    classid = params[:classid]
    @student_attendances = StudentAttendance.search2(classid)
    @student_attendances_class = @student_attendances.group_by{|x|x.weeklytimetable_details_id}
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

  def edit_multiple
      @studentattendance_ids = params[:student_attendance_ids]
      unless @studentattendance_ids.blank? 
  	      @studentattendances = StudentAttendance.find(@studentattendance_ids)
  	      @student_count = @studentattendances.map(&:student_id).uniq.count
  	      @edit_type = params[:student_attendance_submit_button]  
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
      @weeklytimetable_details_ids = params[:weeklytimetable_details_ids]
      @studentattendances = StudentAttendance.find(@studentattendance_ids)  
      @studentattendances_group = @studentattendances.group_by{|x|x.student_id} 
      
      #####
      if submit_val == 'Apply Changes'
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
      	      flash[:notice] = "<b>Schedule</b> are updated. You may view/print <b>Attendance Form </b>(c/w date & time slot). <br>To update <b>student attendance</b>, check/uncheck check boxes accordingly and click <b>submit</b>."
      	      format.xml  { head :ok }
      	      flash.discard
  	      end
  	  else
      ##### 
      #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      											 
      @studentattendances.sort_by{|x|x.student.name}.each_with_index do |student_attendance, index| 
	      if @attends && @attends[index.to_s]!=nil
	          student_attendance.attend = true
	      else
	          student_attendance.attend = false
	      end
        student_attendance.save 
 		  end	
 		  
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
  	                if no == 2 
    									 @next = @next+no+1 
    								end 
  	          
  	            end
  	    
  	        end
  	    end
 		  
 		  flash[:notice] = "Updated student attendance!"
  	  redirect_to student_attendances_path
  	  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	    end
  	  
  	  
  end   			#--end of def update_multiple
   
  def borang_kehadiran
      @studentattendance_ids = params[:iddd]    #[628,629,630,631,632,633]
      @student_attendances = StudentAttendance.find(:all, :conditions => ['id IN (?)',@studentattendance_ids])
      @studentattendances_group = @student_attendances.group_by{|x|x.student_id} 
      render :layout => 'report'
  end
  

   
end
