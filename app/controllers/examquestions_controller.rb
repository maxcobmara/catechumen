class ExamquestionsController < ApplicationController
  # GET /examquestions
  # GET /examquestions.xml
  def index
    #-----in case-use these 4 lines-------
    #@programmes = Programme.roots
    #@examquestions = Examquestion.search2(params[:programmid])    #all if not specified
    #@subject_exams = @examquestions.group_by { |t| t.subject_details }
    #@topic_exams = @examquestions.group_by { |t| t.topic_id }
    #-----in case-use these 4 lines-------
    
    @position_exist = current_user.staff.position
    if @position_exist  
      @lecturer_programme = current_user.staff.position.unit
      unless @lecturer_programme.nil?
        @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
      end
      #@programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
      unless @programme.nil?
        @programme_id = @programme.id
      else
        if @lecturer_programme == 'Commonsubject'
          @programme_id ='1'
        else
          @programme_id='0'
        end
      end
      @examquestions = Examquestion.search2(@programme_id) 
      @programme_exams = @examquestions.group_by {|t| t.subject.root} 
    end  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examquestions }
      #to do - refer examanalysis.rb & examanalysis_controller.rb for sample
      format.xls {send_data @examquestions.to_xls(:name=>"Examination Questions",:headers => Examquestion.header_excel, 
  		:columns => Examquestion.column_excel ), :file_name => 'examquestions.xls' }
    end
  end

  # GET /examquestions/1
  # GET /examquestions/1.xml
  def show
    @examquestion = Examquestion.find(params[:id])
    @q_frequency=Examquestion.find(:all, :joins=>:exams,:conditions=>['examquestion_id=?',(params[:id])])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examquestion }
    end
  end

  # GET /examquestions/new
  # GET /examquestions/new.xml
  def new
    @examquestion = Examquestion.new
    #--newly added
    @lecturer_programme = current_user.staff.position.unit      
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_listing = Programme.find(:all, :conditions=> ['id=?',@programme.id]).to_a
      @preselect_prog = @programme.id
      @all_subject_ids = Programme.find(@preselect_prog).descendants.at_depth(2).map(&:id)
      if @lecturer_programme == 'Commonsubject'
        @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subject_ids, @lecturer_programme],:order=>'ancestry ASC') 
      else
        @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subject_ids, 'Subject'], :order=>'ancestry ASC')  #'Subject' 
      end
    else
      @programme_listing = Programme.roots
    end
    #--newly added
    #@examquestion.exammcqanswers.build
    #@examquestion.examsubquestions.build
    3.times { @examquestion.shortessays.build }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examquestion }
    end
  end

  # GET /examquestions/1/edit
  def edit
    @examquestion = Examquestion.find(params[:id])
    
    #--newly added--same as create--required during edit
    @lecturer_programme = current_user.staff.position.unit      
    if @lecturer_programme != 'Commonsubject'
      @programme = Programme.find(:first,:conditions=>["name ILIKE (?) AND ancestry_depth=?","%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?  
      @programme_listing = Programme.find(:all, :conditions=> ['id=?',@programme.id]).to_a
      @preselect_prog = @programme.id
      @all_subject_ids = Programme.find(@preselect_prog).descendants.at_depth(2).map(&:id)
      unless @examquestion.topic_id.nil?
        @all_subjects1 = Programme.find(@examquestion.topic.root.id).descendants.at_depth(2).map(&:id)
      else
        @all_subjects2 = Programme.find(@examquestion.programme_id).descendants.at_depth(2).map(&:id)
      end
      
      if @lecturer_programme == 'Commonsubject'
        @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subject_ids, @lecturer_programme],:order=>'ancestry ASC')
        unless @examquestion.topic_id.nil?
          @subjects1 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects1, @lecturer_programme],:order=>'ancestry ASC')  
        else
          @subjects2 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects2, @lecturer_programme],:order=>'ancestry ASC')  
        end 
      else
        @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subject_ids, 'Subject'],:order=>'ancestry ASC')  #'Subject' 
        unless @examquestion.topic_id.nil?
          @subjects1 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects1, 'Subject'], :order=>'ancestry ASC')  
        else
          @subjects2 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects2, 'Subject'], :order=>'ancestry ASC')  
        end
      end
    else  #for admin (has no programme in current_user.staff.position.unit)
      @programme_listing = Programme.roots
      unless @examquestion.subject_id.nil? || @examquestion.subject_id.blank?   #if subject already selected
        @subjects1 = Programme.find(@examquestion.subject.root_id).descendants.at_depth(2).sort_by{|x|x.ancestry}
      else  # if subject not selected yet 
        @subjects1 = Programme.find(:all, :conditions=>['ancestry_depth=?',2],:order=>'ancestry ASC')
      end
    end
    #--newly added--same as create--required during edit
  end

  # POST /examquestions
  # POST /examquestions.xml
  def create
    @examquestion = Examquestion.new(params[:examquestion])
    
    #--newly added--same as edit--required when incomplete data submitted
    @lecturer_programme = current_user.staff.position.unit      
    if @lecturer_programme != 'Commonsubject'
      @programme = Programme.find(:first,:conditions=>["name ILIKE (?) AND ancestry_depth=?","%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?  
      @programme_listing = Programme.find(:all, :conditions=> ['id=?',@programme.id]).to_a
      @preselect_prog = @programme.id
      @all_subject_ids = Programme.find(@preselect_prog).descendants.at_depth(2).map(&:id)
      unless @examquestion.topic_id.nil?
        @all_subjects1 = Programme.find(@examquestion.topic.root.id).descendants.at_depth(2).map(&:id)
      else
        @all_subjects2 = Programme.find(@examquestion.programme_id).descendants.at_depth(2).map(&:id)
      end
      
      if @lecturer_programme == 'Commonsubject'
        @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subject_ids, @lecturer_programme],:order=>'ancestry ASC')
        unless @examquestion.topic_id.nil?
          @subjects1 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects1, @lecturer_programme],:order=>'ancestry ASC')  
        else
          @subjects2 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects2, @lecturer_programme],:order=>'ancestry ASC')  
        end 
      else
        @subjectlist_preselect_prog = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subject_ids, 'Subject'],:order=>'ancestry ASC')   
        unless @examquestion.topic_id.nil?
          @subjects1 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects1, 'Subject'],:order=>'ancestry ASC')  
        else
          @subjects2 = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',@all_subjects2, 'Subject'],:order=>'ancestry ASC')  
        end
      end
    else  
      @programme_listing = Programme.roots
    end
    #--newly added--same as edit--required when incomplete data submitted
    
    respond_to do |format|
      if @examquestion.save
        flash[:notice] = 'Examquestion was successfully created.'
        format.html { redirect_to(@examquestion) }
        format.xml  { render :xml => @examquestion, :status => :created, :location => @examquestion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examquestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examquestions/1
  # PUT /examquestions/1.xml
  def update
    #raise params.inspect
    @examquestion = Examquestion.find(params[:id])
    #@subject_exams = @examquestions.group_by { |t| t.subject_details }

    respond_to do |format|
      if @examquestion.update_attributes(params[:examquestion])
        flash[:notice] = 'Examquestion was successfully updated.'
        format.html { redirect_to(@examquestion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examquestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examquestions/1
  # DELETE /examquestions/1.xml
  def destroy
    @examquestion = Examquestion.find(params[:id])
    #22Apr2013--avoid deletion of examquestion that exist in exams-temp
    @exist_in_exam = Exam.find(:all, :joins=>:examquestions, :conditions=> ['examquestion_id=?',params[:id]]).count
    if @exist_in_exam == 0
        @examquestion.destroy
    else
        flash[:error] = 'This examquestion EXIST in examination and is not allowed for deletion.'
    end
    #22Apr2013--avoid deletion of examquestion that exist in exams
    
    respond_to do |format|
      format.html { redirect_to(examquestions_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_subject
    @lecturer_programme = current_user.staff.position.unit 
    @programme_id = params[:programmeid]
    unless @programme_id.blank? 
      all_subject_ids = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
      if @lecturer_programme == 'Commonsubject'
        @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, @lecturer_programme],:order=>'ancestry ASC')  
      else
        #@subjects = Subject.find(:all, :joins => :programmes,:conditions => ['programme_id=?', @programme_id])
        @subjects = Programme.find(:all, :conditions=>['id IN(?) AND course_type=?',all_subject_ids, 'Subject'],:order=>'ancestry ASC')  
      end
    end
    render :partial => 'view_subject', :layout => false
  end
  
  def view_topic
    @subject_id = params[:subjectid]
    unless @subject_id.blank? 
      @topics = Programme.find(@subject_id).descendants.at_depth(3)
    end
    render :partial => 'view_topic', :layout => false
  end

end
