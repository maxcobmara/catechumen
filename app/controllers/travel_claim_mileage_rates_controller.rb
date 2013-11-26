class TravelClaimMileageRatesController < ApplicationController
  # GET /travel_claim_mileage_rates
  # GET /travel_claim_mileage_rates.xml
  def index
    @travel_claim_mileage_rates = TravelClaimMileageRate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travel_claim_mileage_rates }
    end
  end

  # GET /travel_claim_mileage_rates/1
  # GET /travel_claim_mileage_rates/1.xml
  def show
    @travel_claim_mileage_rate = TravelClaimMileageRate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travel_claim_mileage_rate }
    end
  end

  # GET /travel_claim_mileage_rates/new
  # GET /travel_claim_mileage_rates/new.xml
  def new
    @travel_claim_mileage_rate = TravelClaimMileageRate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @travel_claim_mileage_rate }
    end
  end

  # GET /travel_claim_mileage_rates/1/edit
  def edit
    @travel_claim_mileage_rate = TravelClaimMileageRate.find(params[:id])
  end

  # POST /travel_claim_mileage_rates
  # POST /travel_claim_mileage_rates.xml
  def create
    @travel_claim_mileage_rate = TravelClaimMileageRate.new(params[:travel_claim_mileage_rate])

    respond_to do |format|
      if @travel_claim_mileage_rate.save
        format.html { redirect_to(travel_claim_mileage_rates_url, :notice => 'TravelClaimMileageRate was successfully created.') }
        format.xml  { render :xml => @travel_claim_mileage_rate, :status => :created, :location => @travel_claim_mileage_rate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travel_claim_mileage_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travel_claim_mileage_rates/1
  # PUT /travel_claim_mileage_rates/1.xml
  def update
    @travel_claim_mileage_rate = TravelClaimMileageRate.find(params[:id])

    respond_to do |format|
      if @travel_claim_mileage_rate.update_attributes(params[:travel_claim_mileage_rate])
        format.html { redirect_to(travel_claim_mileage_rates_url, :notice => 'TravelClaimMileageRate was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travel_claim_mileage_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_claim_mileage_rates/1
  # DELETE /travel_claim_mileage_rates/1.xml
  def destroy
    @travel_claim_mileage_rate = TravelClaimMileageRate.find(params[:id])
    @travel_claim_mileage_rate.destroy

    respond_to do |format|
      format.html { redirect_to(travel_claim_mileage_rates_url) }
      format.xml  { head :ok }
    end
  end
end
