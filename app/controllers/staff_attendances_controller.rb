class StaffAttendancesController < ApplicationController
  # GET /staff_attendances
  # GET /staff_attendances.xml
  def index
    @staff_attendances = StaffAttendance.is_controlled.paginate(:per_page => 50, :page => params[:page])
    @staff_attendance_days = @staff_attendances.group_by {|t| t.group_by_thingy }
    
    @mylate_attendances = StaffAttendance.find_mylate
    @approvelate_attendances = StaffAttendance.find_approvelate


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staff_attendances }
    end
  end

  # GET /staff_attendances/1
  # GET /staff_attendances/1.xml
  def show
    @staff_attendance = StaffAttendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staff_attendance }
    end
  end

  # GET /staff_attendances/new
  # GET /staff_attendances/new.xml
  def new
    @staff_attendance = StaffAttendance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staff_attendance }
    end
  end

  # GET /staff_attendances/1/edit
  def edit
    @staff_attendance = StaffAttendance.find(params[:id])
  end

  # POST /staff_attendances
  # POST /staff_attendances.xml
  def create
    @staff_attendance = StaffAttendance.new(params[:staff_attendance])

    respond_to do |format|
      if @staff_attendance.save
        format.html { redirect_to(@staff_attendance, :notice => 'StaffAttendance was successfully created.') }
        format.xml  { render :xml => @staff_attendance, :status => :created, :location => @staff_attendance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staff_attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staff_attendances/1
  # PUT /staff_attendances/1.xml
  def update
    @staff_attendance = StaffAttendance.find(params[:id])

    respond_to do |format|
      if @staff_attendance.update_attributes(params[:staff_attendance])
        format.html { redirect_to(@staff_attendance, :notice => 'StaffAttendance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staff_attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staff_attendances/1
  # DELETE /staff_attendances/1.xml
  def destroy
    @staff_attendance = StaffAttendance.find(params[:id])
    @staff_attendance.destroy

    respond_to do |format|
      format.html { redirect_to(staff_attendances_url) }
      format.xml  { head :ok }
    end
  end
  
  def manage
    @mylate_attendances = StaffAttendance.find_mylate
    @approvelate_attendances = StaffAttendance.find_approvelate


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staff_attendances }
    end  
  end
  
  def approve
    @staff_attendance = StaffAttendance.find(params[:id])
  end
  
  
  
  def actionable
    StaffAttendance.update_all(["trigger=?", true], :id => params[:triggers])
    StaffAttendance.update_all(["trigger =?", false], :id => params[:ignores])
    redirect_to :back
  end
  
  def status
    @thismonthreds = StaffAttendance.this_month_red
    @lastmonthreds = StaffAttendance.last_month_red
    @prevmonthreds = StaffAttendance.previous_month_red
    
    @thismonthgreens = StaffAttendance.this_month_green
    @lastmonthgreens = StaffAttendance.last_month_green
    @prevmonthgreens = StaffAttendance.previous_month_green
  end
  
end
