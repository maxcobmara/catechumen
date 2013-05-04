class PtdosController < ApplicationController
  # GET /ptdos
  # GET /ptdos.xml
  def index
    @ptdos = Ptdo.with_permissions_to(:index)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptdos }
    end
  end

  # GET /ptdos/1
  # GET /ptdos/1.xml
  def show
    @ptdo = Ptdo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptdo }
    end
  end

  # GET /ptdos/new
  # GET /ptdos/new.xml
  def new
    @ptdo = Ptdo.new(:ptschedule_id => params[:ptschedule_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ptdo }
    end
  end

  # GET /ptdos/1/edit
  def edit
    @ptdo = Ptdo.find(params[:id])
  end

  # POST /ptdos
  # POST /ptdos.xml
  def create
    @ptdo = Ptdo.new(params[:ptdo])

    respond_to do |format|
      if @ptdo.save
        flash[:notice] = 'Staff Training was successfully created.'
        format.html { redirect_to(@ptdo) }
        format.xml  { render :xml => @ptdo, :status => :created, :location => @ptdo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ptdo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ptdos/1
  # PUT /ptdos/1.xml
  def update
    @ptdo = Ptdo.find(params[:id])

    respond_to do |format|
      if @ptdo.update_attributes(params[:ptdo])
        flash[:notice] = 'Staff Training was successfully updated.'
        format.html { redirect_to(@ptdo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ptdo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptdos/1
  # DELETE /ptdos/1.xml
  def destroy
    @ptdo = Ptdo.find(params[:id])
    @ptdo.destroy

    respond_to do |format|
      format.html { redirect_to(ptdos_url) }
      format.xml  { head :ok }
    end
  end
end
