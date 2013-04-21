class ExamquestionsController < ApplicationController
  # GET /examquestions
  # GET /examquestions.xml
  def index
    #-----in case-use these 4 lines-------
    @programmes = Programme.roots
    #@examquestions = Examquestion.search2(params[:programmid])    #all if not specified
    #@subject_exams = @examquestions.group_by { |t| t.subject_details }
    #@topic_exams = @examquestions.group_by { |t| t.topic_id }
    #-----in case-use these 4 lines-------
    
    @aaaaa=params[:subjectselect]
    submit_val = params[:submit_button1]
    if (params[:subjectselect] =='0' || params[:subjectselect] ==0) && submit_val == "Search"
        @examquestions = Examquestion.search2(params[:programmid])    #all if not specified
    elsif (params[:subjectselect] !='' || params[:subjectselect] !=nil) && submit_val == "Search"
        @examquestions = Examquestion.find(:all, :conditions=>['subject_id=?',@aaaaa])
    elsif !submit_val
        @examquestions = Examquestion.search2(params[:programmid])    #all if not specified
    end 
    @subject_exams = @examquestions.group_by { |t| t.subject_details }    
    @topic_exams = @examquestions.group_by { |t| t.topic_id } 
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examquestions }
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
  end

  # POST /examquestions
  # POST /examquestions.xml
  def create
    @examquestion = Examquestion.new(params[:examquestion])

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
    @examquestion.destroy

    respond_to do |format|
      format.html { redirect_to(examquestions_url) }
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
  
  def view_topic
    @subject_id = params[:subjectid]
    unless @subject_id.blank? 
      @topics = Programme.find(@subject_id).descendants.at_depth(3)
    end
    render :partial => 'view_topic', :layout => false
  end

end
