class ExammarksController < ApplicationController
  # GET /exammarks
  # GET /exammarks.xml
  def index
    @exammarks = Exammark.all

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
	  if @new_type && @new_type == "1"      # for multiple entry
	    #-------------------------------------------------------
	    @exammaker_id = params[:exammakerid]
	    unless @exammaker_id.blank? || @exammaker_id.nil? || @exammaker_id == 0 || @exammaker_id == '0'
			@examquestions = Exammaker.find(@exammaker_id).examquestions
			@selected_subject = Exammaker.find(@exammaker_id).subject_id
			@students = Student.available_students2(@selected_subject) 
			@students_qty = @students.count
			@exammarks = Array.new(@students_qty) { Exammark.new } 	                              #(params[:exammarks])
			@exammarks.each do |exammark|                                                         # have to build nested attribute, mark(formative) inside of each item of grade array
				exammark.marks.build          
			end
	    end     #end for unless..
  
	    #@klass_of_subject = Klass.find(:first, :conditions=> ['subject_id=?',@selected_subject])
	    #unless @klass_of_subject.blank? || @klass_of_subject.nil?
	    #@students_selected_subject = @klass_of_subject.students
	    #@students_qty = @students_selected_subject.count
	    
	    
	    #------------------------------------------------------
	  elsif @new_type && @new_type =="0"    # for single entry
	    @exammark = Exammark.new(params[:exammark]) 
      @exammark.marks.build

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @exammark }
      end
	  end  

  end

  # GET /exammarks/1/edit
  def edit
    @exammark = Exammark.find(params[:id])
  end

  # POST /exammarks
  # POST /exammarks.xml
  def create
    #raise params.inspect
    @create_type = params[:new_submit]                                            # retrieve - parameter sent via submit button
    
    if @create_type == "Create By Paper"                                       # create multiple records 
        @new_type = "1"
        #----------------
        @exammarks_all = params[:exammarks]  
        @exammarks = params[:exammarks].values.collect { |exammark| Exammark.new(exammark) }
		    #---retrieve params value of entered data by user - for action:new usage --> when errors arrise & requires re-submission of form 
			  @exammaker_id = Exammark.set_params_value(@exammarks,0)
			  @selected_subject = Exammaker.find(@exammaker_id).subject_id
			  @examquestions = Exammaker.find(@exammaker_id).examquestions
			  @students = Student.available_students2(@selected_subject) 
			  @students_qty = @students.count
			  ####################
			  #---this part will assign & save total marks (of exammaker[exam paper]) taken directly to grade table - field exam1marks)
        #@exammaker_id = params[:exammark][:exammaker_id]
        #@subject_id = Exammaker.find(@exammaker_id).subject_id   #line 79-@selected_subject
        @examtype = Exammaker.find(@exammaker_id).examtype
        #@student_id = params[:exammark][:student_id] #line 81--> @students (multiple)
        # to retrieve multiple grades for multiple student of 1 subject!--
        
          @grades1 = Grade.find(:all, :conditions=> ['student_id=? and subject_id=?', @student_id, @subject_id])
        #@grade1 = Grade.find(:first, :conditions=> ['student_id=? and subject_id=?', @student_id, @subject_id])
        @all_marks= params[:exammark][:marks_attributes]
        @sum_of_marks = Exammark.sum_marks(@all_marks)
        unless @grade1.nil? || @grade1.blank?
          @grade1.exam1marks = @sum_of_marks
          @grade1.save if @grade1.exam1marks && @examtype == "2"  #2 for Peperiksaan Akhir Semester
        end
        #---exam1marks field (grade table) loaded with total marks & saved in db-------------------------------------------------
			  ####################
			  #------------------------------------------------------------------------------
        if @exammarks.all?(&:valid?) 
          @exammarks.each(&:save!)                                      # ref: to retrieve each value of @exammarks --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
            flash[:notice] = 'Successfully saved all records'
            redirect_to :action => 'index'
        else                                                                      
			    @exammarkerrormsg = Exammark.set_error_messages(@exammarks) 
			    flash[:error] = @exammarkerrormsg	#red box                              
          flash[:notice] = 'Data supplied was invalid. Please insert all data accordingly. All fields are compulsory.'
          render :action => 'new'
          flash.discard
        end
        #--------------------
    elsif @create_type == "Create"                                                # create one record
        #raise params.inspect
        @new_type ="0"
        #---this part will assign & save total marks (of exammaker[exam paper]) taken directly to grade table - field exam1marks)
        @exammaker_id = params[:exammark][:exammaker_id]
        @subject_id = Exammaker.find(@exammaker_id).subject_id
        @examtype = Exammaker.find(@exammaker_id).examtype
        @student_id = params[:exammark][:student_id]
        @grade1 = Grade.find(:first, :conditions=> ['student_id=? and subject_id=?', @student_id, @subject_id])
        @all_marks= params[:exammark][:marks_attributes]
        @sum_of_marks = Exammark.sum_marks(@all_marks)
        unless @grade1.nil? || @grade1.blank?
          @grade1.exam1marks = @sum_of_marks
          @grade1.save if @grade1.exam1marks && @examtype == "2"  #2 for Peperiksaan Akhir Semester
        end
        #---exam1marks field (grade table) loaded with total marks & saved in db-------------------------------------------------
        
        @exammark = Exammark.new(params[:exammark])
        @exammark_all = params[:exammark]  
        
        respond_to do |format|
          if @exammark.save
            format.html { redirect_to(@exammark, :notice => 'Exammark was successfully created.') }
            format.xml  { render :xml => @exammark, :status => :created, :location => @exammark }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @exammark.errors, :status => :unprocessable_entity }
          end
        end
    end

    
  end

  # PUT /exammarks/1
  # PUT /exammarks/1.xml
  def update
    #raise params.inspect
    @exammark = Exammark.find(params[:id])
    
    #---this part will assign & save total marks (of exammaker[exam paper]) taken directly to grade table - field exam1marks)
    @exammaker_id = @exammark.exammaker_id 
    @subject_id = Exammaker.find(@exammaker_id).subject_id
    @examtype = Exammaker.find(@exammaker_id).examtype
    @student_id = @exammark.student_id 
    @grade = Grade.find(:first, :conditions=> ['student_id=? and subject_id=?', @student_id, @subject_id])
    @grade.exam1marks = @exammark.total_marks 
    @grade.save if @grade.exam1marks && @examtype == "2"  #2 for Peperiksaan Akhir Semester
    #---exam1marks field (grade table) loaded with total marks & saved in db-------------------------------------------------

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
  
  def view_student
    @exammaker_id = params[:exammakerid]    #Refers to label:subject 
    
    unless @exammaker_id.blank? || @exammaker_id.nil? 
      @examquestions = Exammaker.find(@exammaker_id).examquestions
      @subject = Exammaker.find(@exammaker_id).subject_id
      @students = Student.available_students2(@subject) 
    end
  	render :partial => 'student_listing', :layout => false
  end
  
  #def view_try
    #@exammarkitem = params[:exammarkitem]
    
    #if @exammarkitem.blank? || @exammarkitem.nil?
    #else
      #@exammarkitem_A = []
    	#@exammarkitem_A = @exammarkitem.split(',')
      #@total_exammark2 = 0.00   
      #@exammarkitem = ""
			#@exammarkitem_A.each do |markitem|
				#@total_exammark2 = @total_exammark2+markitem.to_f
				#@exammarkitem = @exammarkitem+markitem.to_s
			#end
    #end
    
    #@index_value = params[:indexval]
    #if @index_value.blank? || @index_value.nil?
   # else
       # @exammark_one=params[:exammark_one]
        #@prev_total=params[:prev_total]
    #end
    
    #@total_exammark = params[:exammark0].to_f+ params[:exammark1].to_f+ params[:exammark2].to_f
    #@exammark_attr = params[:exammark_attr]
    #render :partial => 'total_marks', :layout => false
  #end
  
end
