class BookingvehiclesController < ApplicationController
  # GET /bookingvehicles
  # GET /bookingvehicles.xml
  filter_access_to :all
  
  def index
    @bookingvehicles = Bookingvehicle.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookingvehicles }
    end
  end

  # GET /bookingvehicles/1
  # GET /bookingvehicles/1.xml
  def show
    @bookingvehicle = Bookingvehicle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookingvehicle }
    end
  end

  # GET /bookingvehicles/new
  # GET /bookingvehicles/new.xml
  def new
    @bookingvehicle = Bookingvehicle.new
	#5.times {@bookingvehicle.passengers.build}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookingvehicle }
    end
  end

  # GET /bookingvehicles/1/edit
  def edit
    @bookingvehicle = Bookingvehicle.find(params[:id])
  end

  # POST /bookingvehicles
  # POST /bookingvehicles.xml
  def create
    @bookingvehicle = Bookingvehicle.new(params[:bookingvehicle])

    respond_to do |format|
      if @bookingvehicle.save
        flash[:notice] = 'Bookingvehicle was successfully created.'
        format.html { redirect_to(@bookingvehicle) }
        format.xml  { render :xml => @bookingvehicle, :status => :created, :location => @bookingvehicle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookingvehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookingvehicles/1
  # PUT /bookingvehicles/1.xml
  def update
    @bookingvehicle = Bookingvehicle.find(params[:id])

    respond_to do |format|
      if @bookingvehicle.update_attributes(params[:bookingvehicle])
        flash[:notice] = 'Bookingvehicle was successfully updated.'
        format.html { redirect_to(@bookingvehicle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookingvehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookingvehicles/1
  # DELETE /bookingvehicles/1.xml
  def destroy
    @bookingvehicle = Bookingvehicle.find(params[:id])
    @bookingvehicle.destroy

    respond_to do |format|
      format.html { redirect_to(bookingvehicles_url) }
      format.xml  { head :ok }
    end
  end
  
  def endorse
     @bookingvehicle = Bookingvehicle.find(params[:id])
  end
   
  def approve
    @bookingvehicle = Bookingvehicle.find(params[:id])
  end
  
   def vehicle_form
    @bookingvehicle = Bookingvehicle.find(params[:id])
    render :layout => 'report'
  end
end
