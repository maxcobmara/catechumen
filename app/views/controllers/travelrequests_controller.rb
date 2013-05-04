class TravelrequestsController < ApplicationController
  # GET /travelrequests
  # GET /travelrequests.xml
  def index
    @travelrequests = Travelrequest.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travelrequests }
    end
  end

  # GET /travelrequests/1
  # GET /travelrequests/1.xml
  def show
    @travelrequest = Travelrequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travelrequest }
    end
  end

  # GET /travelrequests/new
  # GET /travelrequests/new.xml
  def new
    @travelrequest = Travelrequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @travelrequest }
    end
  end

  # GET /travelrequests/1/edit
  def edit
    @travelrequest = Travelrequest.find(params[:id])
  end

  # POST /travelrequests
  # POST /travelrequests.xml
  def create
    @travelrequest = Travelrequest.new(params[:travelrequest])

    respond_to do |format|
      if @travelrequest.save
        flash[:notice] = 'Travelrequest was successfully created.'
        format.html { redirect_to(@travelrequest) }
        format.xml  { render :xml => @travelrequest, :status => :created, :location => @travelrequest }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travelrequest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travelrequests/1
  # PUT /travelrequests/1.xml
  def update
    @travelrequest = Travelrequest.find(params[:id])

    respond_to do |format|
      if @travelrequest.update_attributes(params[:travelrequest])
        flash[:notice] = 'Travelrequest was successfully updated.'
        format.html { redirect_to(@travelrequest) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travelrequest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travelrequests/1
  # DELETE /travelrequests/1.xml
  def destroy
    @travelrequest = Travelrequest.find(params[:id])
    @travelrequest.destroy

    respond_to do |format|
      format.html { redirect_to(travelrequests_url) }
      format.xml  { head :ok }
    end
  end
end
