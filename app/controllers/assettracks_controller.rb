class AssettracksController < ApplicationController
  # GET /assettracks
  # GET /assettracks.xml
  def index
  #  @assettracks = Assettrack.all
    @assettracks = Assettrack.search(params[:search])
    @assettrack_assets = @assettracks.group_by { |t| t.assetrack_details }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assettracks }
    end
  end

  # GET /assettracks/1
  # GET /assettracks/1.xml
  def show
    @assettrack = Assettrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assettrack }
    end
  end

  # GET /assettracks/new
  # GET /assettracks/new.xml
  def new
    @assettrack = Assettrack.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assettrack }
    end
  end

  # GET /assettracks/1/edit
  def edit
    @assettrack = Assettrack.find(params[:id])
  end
  
  def register
    @assettrack = Assettrack.find(params[:id])
    # @assettrack_assets = @assettracks.group_by { |t| t.assetrack_details }
    render :layout => 'report'
  end
  
  def vehicle_booking
    @assettrack = Assettrack.find(params[:id])
    render :layout => 'report'
  end
  

  # POST /assettracks
  # POST /assettracks.xml
  def create
    @assettrack = Assettrack.new(params[:assettrack])

    respond_to do |format|
      if @assettrack.save
        flash[:notice] = 'Assettrack was successfully created.'
        format.html { redirect_to(@assettrack) }
        format.xml  { render :xml => @assettrack, :status => :created, :location => @assettrack }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assettrack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assettracks/1
  # PUT /assettracks/1.xml
  def update
    @assettrack = Assettrack.find(params[:id])

    respond_to do |format|
      if @assettrack.update_attributes(params[:assettrack])
        flash[:notice] = 'Assettrack was successfully updated.'
        format.html { redirect_to(@assettrack) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assettrack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assettracks/1
  # DELETE /assettracks/1.xml
  def destroy
    @assettrack = Assettrack.find(params[:id])
    @assettrack.destroy

    respond_to do |format|
      format.html { redirect_to(assettracks_url) }
      format.xml  { head :ok }
    end
  end
end
