class TravelClaimsTransportGroupsController < ApplicationController
  # GET /travel_claims_transport_groups
  # GET /travel_claims_transport_groups.xml
  def index
    @travel_claims_transport_groups = TravelClaimsTransportGroup.find(:all, :order => 'group_name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travel_claims_transport_groups }
    end
  end

  # GET /travel_claims_transport_groups/1
  # GET /travel_claims_transport_groups/1.xml
  def show
    @travel_claims_transport_group = TravelClaimsTransportGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travel_claims_transport_group }
    end
  end

  # GET /travel_claims_transport_groups/new
  # GET /travel_claims_transport_groups/new.xml
  def new
    @travel_claims_transport_group = TravelClaimsTransportGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @travel_claims_transport_group }
    end
  end

  # GET /travel_claims_transport_groups/1/edit
  def edit
    @travel_claims_transport_group = TravelClaimsTransportGroup.find(params[:id])
  end

  # POST /travel_claims_transport_groups
  # POST /travel_claims_transport_groups.xml
  def create
    @travel_claims_transport_group = TravelClaimsTransportGroup.new(params[:travel_claims_transport_group])

    respond_to do |format|
      if @travel_claims_transport_group.save
        format.html { redirect_to(@travel_claims_transport_group, :notice => 'TravelClaimsTransportGroup was successfully created.') }
        format.xml  { render :xml => @travel_claims_transport_group, :status => :created, :location => @travel_claims_transport_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travel_claims_transport_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travel_claims_transport_groups/1
  # PUT /travel_claims_transport_groups/1.xml
  def update
    @travel_claims_transport_group = TravelClaimsTransportGroup.find(params[:id])

    respond_to do |format|
      if @travel_claims_transport_group.update_attributes(params[:travel_claims_transport_group])
        format.html { redirect_to(@travel_claims_transport_group, :notice => 'TravelClaimsTransportGroup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travel_claims_transport_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_claims_transport_groups/1
  # DELETE /travel_claims_transport_groups/1.xml
  def destroy
    @travel_claims_transport_group = TravelClaimsTransportGroup.find(params[:id])
    @travel_claims_transport_group.destroy

    respond_to do |format|
      format.html { redirect_to(travel_claims_transport_groups_url) }
      format.xml  { head :ok }
    end
  end
end
