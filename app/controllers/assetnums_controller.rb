class AssetnumsController < ApplicationController
  # GET /assetnums
  # GET /assetnums.xml
  def index
    @assetnums = Assetnum.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assetnums }
    end
  end

  # GET /assetnums/1
  # GET /assetnums/1.xml
  def show
    @assetnum = Assetnum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assetnum }
    end
  end

  # GET /assetnums/new
  # GET /assetnums/new.xml
  def new
    @assetnum = Assetnum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assetnum }
    end
  end

  # GET /assetnums/1/edit
  def edit
    @assetnum = Assetnum.find(params[:id])
  end

  # POST /assetnums
  # POST /assetnums.xml
  def create
    @assetnum = Assetnum.new(params[:assetnum])

    respond_to do |format|
      if @assetnum.save
        flash[:notice] = 'Assetnum was successfully created.'
        format.html { redirect_to(@assetnum) }
        format.xml  { render :xml => @assetnum, :status => :created, :location => @assetnum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assetnum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assetnums/1
  # PUT /assetnums/1.xml
  def update
    @assetnum = Assetnum.find(params[:id])

    respond_to do |format|
      if @assetnum.update_attributes(params[:assetnum])
        flash[:notice] = 'Assetnum was successfully updated.'
        format.html { redirect_to(@assetnum) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assetnum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assetnums/1
  # DELETE /assetnums/1.xml
  def destroy
    @assetnum = Assetnum.find(params[:id])
    @assetnum.destroy

    respond_to do |format|
      format.html { redirect_to(assetnums_url) }
      format.xml  { head :ok }
    end
  end
end
