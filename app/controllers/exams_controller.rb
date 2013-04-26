class ExamsController < ApplicationController
  # GET /exams
  # GET /exams.xml
  def index
    @exams = Exam.all

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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
  end

  # POST /exams
  # POST /exams.xml
  def create
    @exam = Exam.new(params[:exam])

    respond_to do |format|
      if @exam.save
        #format.html { render :action => "edit" }
        #format.html { redirect_to(@exam, :notice => 'Exam was successfully created.') }
        format.html { redirect_to(@exam, :action => "edit") }
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

    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        format.html { redirect_to(@exam, :notice => 'Exam was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
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
  
  def view_subject_main
    @programme_id = params[:programmeid]
    unless @programme_id.blank? 
      @subjects = Programme.find(@programme_id).descendants.at_depth(2)
    end
    render :partial => 'view_subject_main', :layout => false
  end
  
  def view_subject
    @programme_id = params[:programmeid]
    @exam_id = params[:examid]
    unless @programme_id.blank? 
      @subjects = Programme.find(@programme_id).descendants.at_depth(2)
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
