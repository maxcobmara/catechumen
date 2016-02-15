class AcademicSessionsController < ApplicationController
  filter_resource_access
  # GET /academic_sessions
  # GET /academic_sessions.xml
  def index
    @academic_sessions = AcademicSession.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @academic_sessions }
    end
  end

  # GET /academic_sessions/1
  # GET /academic_sessions/1.xml
  def show
    @academic_session = AcademicSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @academic_session }
    end
  end

  # GET /academic_sessions/new
  # GET /academic_sessions/new.xml
  def new
    @academic_session = AcademicSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @academic_session }
    end
  end

  # GET /academic_sessions/1/edit
  def edit
    @academic_session = AcademicSession.find(params[:id])
  end

  # POST /academic_sessions
  # POST /academic_sessions.xml
  def create
    @academic_session = AcademicSession.new(params[:academic_session])

    respond_to do |format|
      if @academic_session.save
        format.html { redirect_to(@academic_session, :notice => t('academic_session.title2')+" "+t('created')) }
        format.xml  { render :xml => @academic_session, :status => :created, :location => @academic_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @academic_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /academic_sessions/1
  # PUT /academic_sessions/1.xml
  def update
    @academic_session = AcademicSession.find(params[:id])

    respond_to do |format|
      if @academic_session.update_attributes(params[:academic_session])
        format.html { redirect_to(@academic_session, :notice => t('academic_session.title2')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @academic_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /academic_sessions/1
  # DELETE /academic_sessions/1.xml
  def destroy
    @academic_session = AcademicSession.find(params[:id])
    @academic_session.destroy

    respond_to do |format|
      format.html { redirect_to(academic_sessions_url) }
      format.xml  { head :ok }
    end
  end
end
