class TravelClaimsController < ApplicationController
  # GET /travel_claims
  # GET /travel_claims.xml
  def index
    @travel_claims = TravelClaim.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travel_claims }
    end
  end

  # GET /travel_claims/1
  # GET /travel_claims/1.xml
  def show
    @travel_claim = TravelClaim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travel_claim }
    end
  end

  # GET /travel_claims/new
  # GET /travel_claims/new.xml
  def new
    @travel_claim = TravelClaim.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @travel_claim }
    end
  end

  # GET /travel_claims/1/edit
  def edit
    @travel_claim = TravelClaim.find(params[:id])
  end

  # POST /travel_claims
  # POST /travel_claims.xml
  def create
    @travel_claim = TravelClaim.new(params[:travel_claim])

    respond_to do |format|
      if @travel_claim.save
        format.html { redirect_to(@travel_claim, :notice => 'TravelClaim was successfully created.') }
        format.xml  { render :xml => @travel_claim, :status => :created, :location => @travel_claim }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travel_claim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travel_claims/1
  # PUT /travel_claims/1.xml
  def update
    @travel_claim = TravelClaim.find(params[:id])

    respond_to do |format|
      if @travel_claim.update_attributes(params[:travel_claim])
        format.html { redirect_to(@travel_claim, :notice => 'TravelClaim was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travel_claim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_claims/1
  # DELETE /travel_claims/1.xml
  def destroy
    @travel_claim = TravelClaim.find(params[:id])
    @travel_claim.destroy

    respond_to do |format|
      format.html { redirect_to(travel_claims_url) }
      format.xml  { head :ok }
    end
  end
  
  def check
    @travel_claim = TravelClaim.find(params[:id])
  end
  
  def claimprint
    @travel_claim = TravelClaim.find(params[:id])
    @travel_claim_receipt = @travel_claim.travel_claim_receipts.all
    render :layout => 'report'
  end
end
