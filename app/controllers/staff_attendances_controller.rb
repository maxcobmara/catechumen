class StaffAttendancesController < ApplicationController
  # GET /staff_attendances
  # GET /staff_attendances.xml
  def index
    @staff_attendances = StaffAttendance.is_controlled.paginate(:per_page => 50, :page => params[:page])
    @staff_attendance_days = @staff_attendances.group_by {|t| t.group_by_thingy }  

    @ooo = StaffAttendance.is_controlled.group_by {|t| t.group_by_thingy }

    @dept_names=["Teknologi Maklumat","Perhotelan","Perpustakaan","Kaunter","Pembangunan","Kewangan & Stor","Perkhidmatan","Pentadbiran Am","Radiografi","Kejururawatan","Jurupulih Perubatan Anggota (Fisioterapi)","Jurupulih Perubatan Cara Kerja","Penolong Pegawai Perubatan","Pos Basik","Sains Perubatan Asas","Anatomi & Fisiologi","Sains Tingkahlaku","Komunikasi & Sains Pengurusan","Pembangunan Pelatih","Khidmat Sokongan Pelatih","Kokurikulum","Ketua Unit Penilaian & Kualiti"]
    @position_staff_ids = []  
    @staff_in_department = []
    @test_department = []
    @testalldepartmenttgroup = []
    0.upto(21) do |countt|
        @position_staff_ids << Position.find(:first, :conditions=>['unit=?',@dept_names[countt]]).subtree.map(&:staff_id)   
    end
    0.upto(21) do |countt2|
        @staff_in_department << Staff.find(:all,:select=>:thumb_id,:conditions=>['id in (?)',@position_staff_ids[countt2]]).map(&:thumb_id)
    end
    0.upto(21) do |countt3|
        @test_department << StaffAttendance.find(:all,:order => 'logged_at DESC', :limit => 10000, :conditions=>['thumb_id in (?)', @staff_in_department[countt3] ])#.paginate(:per_page => 50, :page => params[:page])
    end 
    0.upto(21) do |countt4|
        @testalldepartmenttgroup<< @test_department[countt4].group_by {|t| t.group_by_thingy }
    end
    
    @selected_date = params[:id]
    if @selected_date.blank?
      @selected_date = "2012-10-16" #default to first page
    end
    @selected_rec_by_date=[]
    for testalldeptgroup in @testalldepartmenttgroup
		    testalldeptgroup.each do |d,k|
				  if d == @selected_date # "2012-10-15" #date
				       @selected_rec_by_date << k
				  end
			  end
		end
   
    #BEST BACKUP-> #@test_itdept = StaffAttendance.find(:all,:order => 'logged_at DESC', :limit => 10000, :conditions=>['thumb_id in (?)',Staff.find(:all,:select=>:thumb_id,:conditions=>['id in (?)',Position.find(:first, :conditions=>['unit=?',"Teknologi Maklumat"]).subtree.map(&:staff_id)]).map(&:thumb_id) ]).paginate(:per_page => 50, :page => params[:page])
  
    #dept = Position.find(:first, :conditions=>['unit=?',"Teknologi Maklumat"]).subtree.map(&:staff_id)
    #dept2 = Position.find(:first, :conditions=>['unit=?',"Perhotelan"]).subtree.map(&:staff_id)

    #staffs_in_dept = Staff.find(:all,:select=>:thumb_id,:conditions=>['id in (?)',dept]).map(&:thumb_id)
    #staffs_in_dept2 = Staff.find(:all,:select=>:thumb_id,:conditions=>['id in (?)',dept2]).map(&:thumb_id)
    
    #@test_itdept = StaffAttendance.find(:all,:order => 'logged_at DESC', :limit => 10000, :conditions=>['thumb_id in (?)',staffs_in_dept ]).paginate(:per_page => 50, :page => params[:page])
    #@test_hoteldept = StaffAttendance.find(:all,:order => 'logged_at DESC', :limit => 10000, :conditions=>['thumb_id in (?)',staffs_in_dept2 ]).paginate(:per_page => 50, :page => params[:page])
     
    #@test_itdept_group = @test_itdept.group_by {|t| t.group_by_thingy }
    #@test_hoteldept_group = @test_hoteldept.group_by {|t| t.group_by_thingy }
    
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
