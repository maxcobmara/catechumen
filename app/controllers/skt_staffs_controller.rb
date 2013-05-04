class SktStaffsController < ApplicationController
  # GET /skt_staffs
  # GET /skt_staffs.xml
  def index
    @skt_staffs = SktStaff.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @skt_staffs }
    end
  end

  # GET /skt_staffs/1
  # GET /skt_staffs/1.xml
  def show
    @skt_staff = SktStaff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @skt_staff }
    end
  end

  # GET /skt_staffs/new
  # GET /skt_staffs/new.xml
  def new
    @skt_staff = SktStaff.new
      1.times do 
        skt_target = @skt_staff.skt_targets.build
        3.times { skt_target.skt_achives.build }
      end
      
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @skt_staff }
    end
  end

  # GET /skt_staffs/1/edit
  def edit
    @skt_staff = SktStaff.find(params[:id])
  end

  # POST /skt_staffs
  # POST /skt_staffs.xml
  def create
    @skt_staff = SktStaff.new(params[:skt_staff])

    respond_to do |format|
      if @skt_staff.save
        flash[:notice] = 'SktStaff was successfully created.'
        format.html { redirect_to(@skt_staff) }
        format.xml  { render :xml => @skt_staff, :status => :created, :location => @skt_staff }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @skt_staff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /skt_staffs/1
  # PUT /skt_staffs/1.xml
  def update
    @skt_staff = SktStaff.find(params[:id])

    respond_to do |format|
      if @skt_staff.update_attributes(params[:skt_staff])
        flash[:notice] = 'SktStaff was successfully updated.'
        format.html { redirect_to(@skt_staff) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @skt_staff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /skt_staffs/1
  # DELETE /skt_staffs/1.xml
  def destroy
    @skt_staff = SktStaff.find(params[:id])
    @skt_staff.destroy

    respond_to do |format|
      format.html { redirect_to(skt_staffs_url) }
      format.xml  { head :ok }
    end
  end
  
  def skt_form
    @skt_staff = SktStaff.find(params[:id])
    render :layout => 'report'
  end
end
