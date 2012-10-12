class StudentCounselingSessionsController < ApplicationController
  filter_resource_access
  # GET /student_counseling_sessions
  # GET /student_counseling_sessions.xml
  def index
    @student_counseling_sessions = StudentCounselingSession.find(:all, :order => 'confirmed_at DESC')
    @appointments = StudentCounselingSession.find_appointment(params[:search])
    @session_dones = StudentCounselingSession.find_session_done(params[:search])
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
end