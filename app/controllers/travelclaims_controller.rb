class TravelclaimsController < ApplicationController
  # GET /travelclaims
  # GET /travelclaims.xml
  def index
    @travelclaims = Travelclaim.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travelclaims }
    end
  end

  # GET /travelclaims/1
  # GET /travelclaims/1.xml
  def show
    @travelclaim = Travelclaim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travelclaim }
    end
  end

  # GET /travelclaims/new
  # GET /travelclaims/new.xml
  def new
    @travelclaim = Travelclaim.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @travelclaim }
    end
  end

  # GET /travelclaims/1/edit
  def edit
    @travelclaim = Travelclaim.find(params[:id])
  end

  # POST /travelclaims
  # POST /travelclaims.xml
  def create
    @travelclaim = Travelclaim.new(params[:travelclaim])

    respond_to do |format|
      if @travelclaim.save
        flash[:notice] = 'Travelclaim was successfully created.'
        format.html { redirect_to(@travelclaim) }
        format.xml  { render :xml => @travelclaim, :status => :created, :location => @travelclaim }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travelclaim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travelclaims/1
  # PUT /travelclaims/1.xml
  def update
    @travelclaim = Travelclaim.find(params[:id])

    respond_to do |format|
      if @travelclaim.update_attributes(params[:travelclaim])
        flash[:notice] = 'Travelclaim was successfully updated.'
        format.html { redirect_to(@travelclaim) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travelclaim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travelclaims/1
  # DELETE /travelclaims/1.xml
  def destroy
    @travelclaim = Travelclaim.find(params[:id])
    @travelclaim.destroy

    respond_to do |format|
      format.html { redirect_to(travelclaims_url) }
      format.xml  { head :ok }
    end
  end
end
