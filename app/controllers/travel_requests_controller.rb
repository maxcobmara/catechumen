class TravelRequestsController < ApplicationController
  # GET /travel_requests
  # GET /travel_requests.xml
  def index
    @travel_requests = TravelRequest.my_travel_requests #.with_permissions_to(:edit).find(:all)
    @for_approvals = TravelRequest.in_need_of_approval

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travel_requests }
    end
  end

  # GET /travel_requests/1
  # GET /travel_requests/1.xml
  def show
    @travel_request = TravelRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travel_request }
    end
  end

  # GET /travel_requests/new
  # GET /travel_requests/new.xml
  def new
    @travel_request = TravelRequest.new
   
    respond_to do |format|
      unless Login.current_login.staff.position.nil?
        format.html # new.html.erb
        format.xml  { render :xml => @travel_request }
      else
        format.html {redirect_to travel_requests_url, :notice =>  t('position_required')+t('travel_request.title')}
        format.xml  { render :xml => @travel_request }
      end
    end
  end

  # GET /travel_requests/1/edit
  def edit
    @travel_request = TravelRequest.find(params[:id])
    respond_to do |format|
      unless Login.current_login.staff.position.nil?
        format.html # new.html.erb
        format.xml  { render :xml => @travel_request }
      else
        format.html {redirect_to travel_requests_url, :notice =>  t('position_required')+t('travel.title')}
        format.xml  { render :xml => @travel_request }
      end
    end
  end

  # POST /travel_requests
  # POST /travel_requests.xml
  def create
    @travel_request = TravelRequest.new(params[:travel_request])

    respond_to do |format|
      if @travel_request.save
        format.html { redirect_to(@travel_request, :notice => t('travel.title')+t('created')) }
        format.xml  { render :xml => @travel_request, :status => :created, :location => @travel_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travel_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travel_requests/1
  # PUT /travel_requests/1.xml
  def update
    @travel_request = TravelRequest.find(params[:id])

    respond_to do |format|
      if @travel_request.update_attributes(params[:travel_request])
        format.html { redirect_to(params[:redirect_location], :notice => t('travel.title')+t('updated')) }
        format.xml  { head :ok }
      
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travel_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_requests/1
  # DELETE /travel_requests/1.xml
  def destroy
    @travel_request = TravelRequest.find(params[:id])
    @travel_request.destroy

    respond_to do |format|
      format.html { redirect_to(travel_requests_url) }
      format.xml  { head :ok }
    end
  end
  
  def travel_log_index
    @my_approved_requests = TravelRequest.find(:all, :conditions => ['staff_id =? AND hod_accept=?', Login.current_login.staff_id, true])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @approved }
    end
  end
  
  def travel_log
     @travel_log = TravelRequest.find(params[:id])
     @travel_request =  @travel_log
  end
end
