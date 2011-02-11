class LeaveforstaffsController < ApplicationController
  # GET /leaveforstaffs
  # GET /leaveforstaffs.xml
  def index
    @leaveforstaffs = Leaveforstaff.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leaveforstaffs }
    end
  end

  # GET /leaveforstaffs/1
  # GET /leaveforstaffs/1.xml
  def show
    @leaveforstaff = Leaveforstaff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @leaveforstaff }
    end
  end

  # GET /leaveforstaffs/new
  # GET /leaveforstaffs/new.xml
  def new
    @leaveforstaff = Leaveforstaff.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @leaveforstaff }
    end
  end

  # GET /leaveforstaffs/1/edit
  def edit
    @leaveforstaff = Leaveforstaff.find(params[:id])
  end

  # POST /leaveforstaffs
  # POST /leaveforstaffs.xml
  def create
    @leaveforstaff = Leaveforstaff.new(params[:leaveforstaff])

    respond_to do |format|
      if @leaveforstaff.save
        flash[:notice] = 'Leaveforstaff was successfully created.'
        format.html { redirect_to(@leaveforstaff) }
        format.xml  { render :xml => @leaveforstaff, :status => :created, :location => @leaveforstaff }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @leaveforstaff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leaveforstaffs/1
  # PUT /leaveforstaffs/1.xml
  def update
    @leaveforstaff = Leaveforstaff.find(params[:id])

    respond_to do |format|
      if @leaveforstaff.update_attributes(params[:leaveforstaff])
        flash[:notice] = 'Leaveforstaff was successfully updated.'
        format.html { redirect_to(@leaveforstaff) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @leaveforstaff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leaveforstaffs/1
  # DELETE /leaveforstaffs/1.xml
  def destroy
    @leaveforstaff = Leaveforstaff.find(params[:id])
    @leaveforstaff.destroy

    respond_to do |format|
      format.html { redirect_to(leaveforstaffs_url) }
      format.xml  { head :ok }
    end
  end
end
