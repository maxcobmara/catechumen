class StaffShiftsController < ApplicationController
  filter_resources_access
  # GET /staff_shifts
  # GET /staff_shifts.xml
  def index
    @staff_shifts = StaffShift.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staff_shifts }
    end
  end

  # GET /staff_shifts/1
  # GET /staff_shifts/1.xml
  def show
    @staff_shift = StaffShift.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staff_shift }
    end
  end

  # GET /staff_shifts/new
  # GET /staff_shifts/new.xml
  def new
    @staff_shift = StaffShift.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staff_shift }
    end
  end

  # GET /staff_shifts/1/edit
  def edit
    @staff_shift = StaffShift.find(params[:id])
  end

  # POST /staff_shifts
  # POST /staff_shifts.xml
  def create
    @staff_shift = StaffShift.new(params[:staff_shift])

    respond_to do |format|
      if @staff_shift.save
        format.html { redirect_to(staff_shifts_url, :notice => t('staffshift.title2')+" "+t('created')) }
        format.xml  { render :xml => @staff_shift, :status => :created, :location => @staff_shift }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staff_shift.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staff_shifts/1
  # PUT /staff_shifts/1.xml
  def update
    @staff_shift = StaffShift.find(params[:id])

    respond_to do |format|
      if @staff_shift.update_attributes(params[:staff_shift])
        format.html { redirect_to(staff_shifts_url, :notice =>  t('staffshift.title2')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staff_shift.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staff_shifts/1
  # DELETE /staff_shifts/1.xml
  def destroy
    @staff_shift = StaffShift.find(params[:id])
    @staff_shift.destroy

    respond_to do |format|
      format.html { redirect_to(staff_shifts_url) }
      format.xml  { head :ok }
    end
  end
end
