class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.xml
  def index
      @filters = Location::FILTERS
      if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
        @locations = Location.send(params[:show])
      else
        @locations = Location.search(params[:search])
      end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new(:parent_id => params[:parent_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end
  
  def indextree
    @locations = Location.search(params[:search])
    #@locations = Location.find(:all, :order => :loc_code)
    #@locations = Location.find(:all)
    #@locations = Location.order(:names_depth_cache).map { |c| ["-" * c.depth + c.name,c.id] }
  end
  
  def kewpa7
    @location = Location.find(params[:id])
    render :layout => 'report'
    #respond_to do |format|
      #format.html # show.html.erb
      #format.xml  { render :xml => @location }
    #end
  end
end
