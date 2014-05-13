class ExamsController < ApplicationController
  # GET /exams
  # GET /exams.xml
  def index
    #@exams = Exam.all
    ##----------
    @position_exist = current_user.staff.position
    if @position_exist  
      @lecturer_programme = current_user.staff.position.unit
      unless @lecturer_programme.nil?
        @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
      end
      unless @programme.nil?
        @programme_id = @programme.id #3 for Kejururawatan
      else
        if @lecturer_programme == 'Commonsubject'
          @programme_id ='1'
        else
          @programme_id='0'
        end
      end
      @exams = Exam.search(@programme_id) 
    end
    ##----------
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exams }
    end
  end

  # GET /exams/1
  # GET /exams/1.xml
  def show
    @exam = Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/new
  # GET /exams/new.xml
  def new
    @exam = Exam.new
    #--newly added
    @lecturer_programme = current_user.staff.position.unit      
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_listing = Programme.find(:all, :conditions=> ['id=?',@programme.id]).to_a
      @preselect_prog = @programme.id
      @all_subject_ids = Programme.find(@preselect_prog).descendants.at_depth(2).map(&:id)
      @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subject_ids, 'Subject'])  #'Subject' 
    else  #if programme not pre-selected (Commonsubject lecturer)
      if @lecturer_programme == 'Commonsubject' #Commonsubject LECTURER have no selected programme
        @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['course_type=?','Commonsubject'])
      end
      @programme_listing = Programme.roots
      @subjectlist_preselect_prog = Programme.at_depth(2)
    end
    #--newly added
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
    @programme_id = @exam.subject.root.id
    @lecturer_programme = current_user.staff.position.unit  
    all_subject_ids = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
    if @lecturer_programme == 'Commonsubject'
      @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, @lecturer_programme])  
    else
      @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, 'Subject'])  #'Subject' 
    end
  end

  # POST /exams
  # POST /exams.xml
  def create
    @exam = Exam.new(params[:exam])
    @create_type = params[:submit_button]             #10June2013-pm
    #if @create_type == "Create"
        #respond_to do |format|
          #if @exam.save
            #format.html { redirect_to(@exam, :notice => 'Exam was successfully created.') }
            ##format.html {render :action => "edit"}
            ##flash[:notice] = 'Exam was successfully created. <b>You may now proceed with examquestion selection.</b>'
            #format.xml  { head :ok }
            #flash.discard
            ##do not remove 2 lines at the bottom of this line
            ##format.html { redirect_to(@exam, :notice => 'Exam was successfully created.') }
            ##format.xml  { render :xml => @exam, :status => :created, :location => @exam }
          #else
            #format.html { render :action => "new" }
            #format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
          #end
        #end
    #elsif @create_type == "Create Template"
    #10June2013-----
       # @exam.klass_id = 0
        #respond_to do |format|
          #if @exam.save
            #format.html { redirect_to(@exam, :notice => 'Exam template was successfully created.') }
            #format.xml  { render :xml => @exam, :status => :created, :location => @exam }
          #else
            #format.html { render :action => "new" }
            #format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
          #end
        #end
    #10June2013-----  
    #end  
    if @create_type == "Create"
        @exam.klass_id = 1  #added for use in E-Query & Report Manager (27Jul2013)
    elsif @create_type == "Create Template"
        @exam.klass_id = 0
    end   
    respond_to do |format|
      if @exam.save
        flash[:notice] = 'Exam was successfully created.'
        format.html { redirect_to (@exam) }
        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.xml
  def update
    #raise params.inspect
    params[:exam][:examquestion_ids] ||= []
    @exam = Exam.find(params[:id])
    
    ###----subject + common subject
    @programme_id = @exam.subject.root.id
    @lecturer_programme = current_user.staff.position.unit  
    all_subject_ids = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
    if @lecturer_programme == 'Commonsubject'
      @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, @lecturer_programme])  
    else
      @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, 'Subject'])  #'Subject' 
    end
    ###----subject + common subject
    
    if @exam.klass_id == 0
    #----for template
      respond_to do |format|
        if @exam.update_attributes(params[:exam]) 
          format.html { redirect_to(@exam, :notice => 'Exam template was successfully updated.') }
          format.xml  { head :ok }
          #format.xml  { render :xml => @exam, :status => :created, :location => @exam }
        else
          format.html { render :action => "new" } #edit
          format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
        end
      end
    #----for template  
    else
      respond_to do |format|
        if @exam.update_attributes(params[:exam]) 
            if params[:exam][:seq]!=nil && ((params[:exam][:seq]).count ==  (params[:exam][:examquestion_ids]).count) 
                format.html { redirect_to(@exam, :notice => 'Exam was successfully updated.') }
                format.xml  { head :ok }
                #format.xml  { render :xml => @exam, :status => :created, :location => @exam }
            else
                #-------(1)for first time data entry--default to edit to set sequence------------------
                #-------(2)for additional data entry--default to edit to set sequence------------------
                #-------for both situation--sequence fields are not available during questions addition
                #-------sequence can only be set once after question is saved into exam----------------
        	      format.html {render :action => "edit"}
        	      flash[:notice] = 'Exam was successfully updated. <b>Please set sequence for each question.</b>'
        	      format.xml  { head :ok }
        	      flash.discard        
                #format.html { render :action => "edit" }
                #format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
                #-------END FOR ABOVE CONDITIONS--------------------------------------------------------          
            end
        else
            format.html { render :action => "edit" }
          	format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
        end
        #if params[:exam][:seq]!=nil
        #------  
            #if params[:exam][:seq].uniq.length == params[:exam][:seq].length  #check for UNIQUE value of sequence selected for each question, if Ok, proceed.
                #if @exam.update_attributes(params[:exam])                     #check if value for all params' value passed validation, if Ok, proceed.
                    #if params[:exam][:seq].include?("Select") ==  false       #(ALL SEQUENCE ARE SET) - NONE OF SEQUENCE value is "Select" - SAVE & redirect to show page...
                        #format.html { redirect_to(@exam, :notice => 'Exam was successfully updated.') }
                        #format.xml  { head :ok }
                    #else                                                      #sequence column in exam table BLANK - no data at all OR include?("Select") == true
                        #format.html {render :action => "edit"}
                        #flash[:error] = 'Please set sequence for each question.'
                        #format.xml  { head :ok }
                        #flash.discard
                    #end
                #else
                    #format.html { render :action => "edit" }
                    #format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
                #end
            #else                                                              #this part is for those with REDUNDANT sequence selected for any 2 or more questions in 1 exam!
                #if params[:exam][:seq].include?("Select") ==  true            #if any of REDUNDANT sequence is 'Select'.
                    #format.html {render :action => "edit"}
                    #flash[:error] = 'Please set sequence for each question'
                    #format.xml  { head :ok }
                    #flash.discard
                #else                                                          #if none of REDUNDANT sequence value is 'Select'
                    #format.html { render :action => "edit" }
                    #flash[:error] = 'No duplicates sequence is allowed.'
                    #format.xml  { head :ok }
                    #flash.discard
                #end
            #end
        #------
        #else
        #------
            #if @exam.update_attributes(params[:exam]) 
                ##format.html { redirect_to(@exam, :notice => 'Exam was successfully updated. Please ') }
                ##format.xml  { head :ok }
                #format.html {render :action => "edit"}
                #flash[:notice] = 'Exam was successfully updated. <b>Please set sequence for each question.</b>'
                #format.xml  { head :ok }
                #flash.discard
            #else
                #format.html { render :action => "edit" }
                #format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
            #end
        #------
        #end  
      end     #end for respond_to do |format|
    end   #end for if @exam.klass_id == 0
    
  end

  # DELETE /exams/1
  # DELETE /exams/1.xml
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to(exams_url) }
      format.xml  { head :ok }
    end
  end
  
  def exampaper
    @exam = Exam.find(params[:id])  
    render :layout => 'report'
  end
  
  def exampaper_separate
    @exam = Exam.find(params[:id])  
    render :layout => 'report'
  end
  
  def exampaper_combine
    @exam = Exam.find(params[:id])  
    render :layout => 'report'
  end
  
  def view_subject_main
    @lecturer_programme = current_user.staff.position.unit 
    @programme_id = params[:programmeid]
    unless @programme_id.blank? 
      all_subject_ids = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
      if @lecturer_programme == 'Commonsubject'
        @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, @lecturer_programme])  
      else
        @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, 'Subject'])  #'Subject' 
      end
      #@subjects = Programme.find(@programme_id).descendants.at_depth(2)
    end
    render :partial => 'view_subject_main', :layout => false
  end
  
  def view_subject
    @lecturer_programme = current_user.staff.position.unit 
    @programme_id = params[:programmeid]
    @exam_id = params[:examid]
    unless @programme_id.blank? 
      all_subject_ids = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
      if @lecturer_programme == 'Commonsubject'
        @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, @lecturer_programme])  
      else
        @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, 'Subject'])  #'Subject' 
      end
      #@subjects = Programme.find(@programme_id).descendants.at_depth(2)
    end
    render :partial => 'view_subject', :layout => false
  end
  
  def view_topic
    @subject = params[:subject]
    @exam_id = params[:examid]
    if @subject!='0' #|| @subject!=0
      @topics = Programme.find(@subject).descendants.at_depth(3)
    end
    render :partial => 'view_topic', :layout => false
  end
  
  def view_questions
    @exam_id = params[:examid]
    @topic_id = params[:topicid]
    unless (@topic_id.blank? && @exam_id.blank?) || @topic_id ==""
      #@questions = Examquestion.find(:all, :conditions => ['subject_id=?',@subject_id])
      @questions = Examquestion.find(:all, :conditions => ['topic_id=? and bplreserve is not true and bplsent is not true', @topic_id])
      @questions_group = @questions.group_by{|x|x.questiontype}
      #@questions2 = Examquestion.find(:all, :conditions => ['subject_id!=?',@subject_id])
      @questions2 = Examquestion.find(:all, :conditions => ['topic_id!=? and bplreserve is not true and bplsent is not true',@topic_id])
      @questions_group2 = @questions2.group_by{|x|x.questiontype}
    end
    render :partial => 'view_questions', :layout => false
  end

end
