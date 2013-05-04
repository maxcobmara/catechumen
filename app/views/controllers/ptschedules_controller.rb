class PtschedulesController < ApplicationController
  # GET /ptschedules
  # GET /ptschedules.xml
  def index
    @ptschedules = Ptschedule.find(:all, :order => "start ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptschedules }
    end
  end

  # GET /ptschedules/1
  # GET /ptschedules/1.xml
  def show
    @ptschedule = Ptschedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptschedule }
    end
  end

  # GET /ptschedules/new
  # GET /ptschedules/new.xml
  def new
    @ptschedule = Ptschedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ptschedule }
    end
  end

  # GET /ptschedules/1/edit
  def edit
    @ptschedule = Ptschedule.find(params[:id])
  end

  # POST /ptschedules
  # POST /ptschedules.xml
  def create
    @ptschedule = Ptschedule.new(params[:ptschedule])

    respond_to do |format|
      if @ptschedule.save
        flash[:notice] = 'Ptschedule was successfully created.'
        format.html { redirect_to(@ptschedule) }
        format.xml  { render :xml => @ptschedule, :status => :created, :location => @ptschedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ptschedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ptschedules/1
  # PUT /ptschedules/1.xml
  def update
    @ptschedule = Ptschedule.find(params[:id])

    respond_to do |format|
      if @ptschedule.update_attributes(params[:ptschedule])
        flash[:notice] = 'Ptschedule was successfully updated.'
        format.html { redirect_to(@ptschedule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ptschedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptschedules/1
  # DELETE /ptschedules/1.xml
  def destroy
    @ptschedule = Ptschedule.find(params[:id])
    @ptschedule.destroy

    respond_to do |format|
      format.html { redirect_to(ptschedules_url) }
      format.xml  { head :ok }
    end
  end
  
  def apply
    @ptschedules = Ptschedule.find(:all, :order => "start ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptschedules }
    end
  end
  
end
