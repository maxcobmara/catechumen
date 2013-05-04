class ExamquestionsController < ApplicationController
  # GET /examquestions
  # GET /examquestions.xml
  def index
   @examquestions = Examquestion.search(params[:subject]) 
   @subject_exams = @examquestions.group_by { |t| t.subject_details }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examquestions }
    end
  end

  # GET /examquestions/1
  # GET /examquestions/1.xml
  def show
    @examquestion = Examquestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examquestion }
    end
  end

  # GET /examquestions/new
  # GET /examquestions/new.xml
  def new
    @examquestion = Examquestion.new
    @examquestion.exammcqanswers.build
     @examquestion.examsubquestions.build
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
    @examquestion = Examquestion.find(params[:id])

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
  
  
end
