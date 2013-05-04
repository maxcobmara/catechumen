class BookingfacilitiesController < ApplicationController
  # GET /bookingfacilities
  # GET /bookingfacilities.xml
  def index
    @bookingfacilities = Bookingfacility.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookingfacilities }
    end
  end

  # GET /bookingfacilities/1
  # GET /bookingfacilities/1.xml
  def show
    @bookingfacility = Bookingfacility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookingfacility }
    end
  end

  # GET /bookingfacilities/new
  # GET /bookingfacilities/new.xml
  def new
    @bookingfacility = Bookingfacility.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookingfacility }
    end
  end

  # GET /bookingfacilities/1/edit
  def edit
    @bookingfacility = Bookingfacility.find(params[:id])
  end
  
  def bookingfacility
     @bookingfacility = Bookingfacility.find(params[:id])
     render :layout => 'report'
  end
  
  def approve
     @bookingfacility = Bookingfacility.find(params[:id])
   end
  
   def facility
      @bookingfacility = Bookingfacility.find(params[:id])
    end

  # POST /bookingfacilities
  # POST /bookingfacilities.xml
  def create
    @bookingfacility = Bookingfacility.new(params[:bookingfacility])

    respond_to do |format|
      if @bookingfacility.save
        flash[:notice] = 'Bookingfacility was successfully created.'
        format.html { redirect_to(@bookingfacility) }
        format.xml  { render :xml => @bookingfacility, :status => :created, :location => @bookingfacility }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookingfacility.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookingfacilities/1
  # PUT /bookingfacilities/1.xml
  def update
    @bookingfacility = Bookingfacility.find(params[:id])

    respond_to do |format|
      if @bookingfacility.update_attributes(params[:bookingfacility])
        flash[:notice] = 'Bookingfacility was successfully updated.'
        format.html { redirect_to(@bookingfacility) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookingfacility.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookingfacilities/1
  # DELETE /bookingfacilities/1.xml
  def destroy
    @bookingfacility = Bookingfacility.find(params[:id])
    @bookingfacility.destroy

    respond_to do |format|
      format.html { redirect_to(bookingfacilities_url) }
      format.xml  { head :ok }
    end
  end
end
