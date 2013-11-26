class StudentCounselingSessionsController < ApplicationController
  ##filter_resource_access #hide first-29Apr2013-no idea
  filter_access_to :all   #feedback_referrer - may have multiple sessions -> refer config/routes.rb
  
  # GET /student_counseling_sessions
  # GET /student_counseling_sessions.xml
  def index
    @student_counseling_sessions = StudentCounselingSession.find(:all, :order => 'confirmed_at DESC')
    @appointments = StudentCounselingSession.find_appointment(params[:search])
    @appointments_by_case = @appointments.group_by{|item|item.case_id}
    @session_dones = StudentCounselingSession.find_session_done(params[:search])
    @session_dones_by_case = @session_dones.group_by{|item|item.case_id}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @student_counseling_sessions }
    end
  end

  # GET /student_counseling_sessions/1
  # GET /student_counseling_sessions/1.xml
  def show
    @student_counseling_session = StudentCounselingSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_counseling_session }
    end
  end

  # GET /student_counseling_sessions/new
  # GET /student_counseling_sessions/new.xml
  def new
    @student_counseling_session = StudentCounselingSession.new
    @case_id = params[:caseid]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_counseling_session }
    end
  end

  # GET /student_counseling_sessions/1/edit
  def edit
    @student_counseling_session = StudentCounselingSession.find(params[:id])
  end

  # POST /student_counseling_sessions
  # POST /student_counseling_sessions.xml
  def create
    @student_counseling_session = StudentCounselingSession.new(params[:student_counseling_session])

    respond_to do |format|
      if @student_counseling_session.save
        format.html { redirect_to(@student_counseling_session, :notice => 'StudentCounselingSession was successfully created.') }
        format.xml  { render :xml => @student_counseling_session, :status => :created, :location => @student_counseling_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student_counseling_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /student_counseling_sessions/1
  # PUT /student_counseling_sessions/1.xml
  def update
    @student_counseling_session = StudentCounselingSession.find(params[:id])
    @abc = StudentDisciplineCase.find(@student_counseling_session.case_id)
    @feedback = params[:student_counseling_session][:feedback]
    if @feedback==1|| @feedback=='1'
        @abc.counselor_feedback = params[:student_counseling_session][:feedback_final]
		else
		    @abc.counselor_feedback =''
    end
    @abc.save
    
    respond_to do |format|
      if @student_counseling_session.update_attributes(params[:student_counseling_session])
        format.html { redirect_to(@student_counseling_session, :notice => 'StudentCounselingSession was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student_counseling_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /student_counseling_sessions/1
  # DELETE /student_counseling_sessions/1.xml
  def destroy
    @student_counseling_session = StudentCounselingSession.find(params[:id])
    @student_counseling_session.destroy

    respond_to do |format|
      format.html { redirect_to(student_counseling_sessions_url) }
      format.xml  { head :ok }
    end
  end
  
  def feedback_referrer 
    #@asset = Asset.find(params[:id]) #params[:id]  --> case_id
    @sessions_by_case = StudentCounselingSession.find(:all, :conditions => ['case_id=?',params[:id]], :order=>'confirmed_at ASC')
    @case_details = StudentDisciplineCase.find(params[:id])
    render :layout => 'report'
  end
    
end