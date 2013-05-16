class StaffAttendancesController < ApplicationController
  # GET /staff_attendances
  # GET /staff_attendances.xml
  def index
    #---
    submit_val = params[:submit_button1]
    #---if search by date---------------------------------------------------------------------------------------------------------
    if submit_val == "Search by date"
        @aa=params[:search_from][:"(1i)"] 
        @bb=params[:search_from][:"(2i)"]
        @cc=params[:search_from][:"(3i)"]
        if @aa!='' && @bb!='' && @cc!=''
            if @cc=='1'||@cc=='2'||@cc=='3'||@cc=='4'||@cc=='5'||@cc=='6'||@cc=='7'||@cc=='8'||@cc=='9'
                 @cc='0'+@cc
            end
            if @bb=='1'||@bb=='2'||@bb=='3'||@bb=='4'||@bb=='5'||@bb=='6'||@bb=='7'||@bb=='8'||@bb=='9'
                 @bb='0'+@bb
            end
            @dadidu=@aa+'-'+@bb+'-'+@cc
        else
            @dadidu=''
        end

        @dd=params[:search_to][:"(1i)"] 
        @ee=params[:search_to][:"(2i)"]
        @ff=params[:search_to][:"(3i)"]
        if @dd!='' && @ee!='' && @ff!=''
            if @ff=='1'||@ff=='2'||@ff=='3'||@ff=='4'||@ff=='5'||@ff=='6'||@ff=='7'||@ff=='8'||@ff=='9'
                  @ff='0'+@ff
            end
            if @ee=='1'||@ee=='2'||@ee=='3'||@ee=='4'||@ee=='5'||@ee=='6'||@ee=='7'||@ee=='8'||@ee=='9'
                 @ee='0'+@ee
            end
            @dadidu2=@dd+'-'+@ee+'-'+@ff  
        else
            @dadidu2=''
        end
    
        params[:search_from]=nil  #this line is required
        params[:search_to]=nil    #this line is required
         
        #insert here....
        if (@dadidu=='' && @dadidu2=='')||(@dadidu==nil && @dadidu2==nil)
            #@documents = Document.find(:all)
        elsif @dadidu!='' && @dadidu2 ==''
            #@documents = Document.find(:all, :conditions=> ['letterxdt=?',"#{@dadidu}"])
            #@abababa = StaffAttendance.find(:all,:conditions=> ['logged_at>=?',"2012-10-15"])
            @abababa = StaffAttendance.find(:all,:conditions=> ['logged_at>=?',"#{@dadidu}"])
            @selected_date = @dadidu
        elsif @dadidu2!='' && @dadidu ==''
            @abababa = StaffAttendance.find(:all,:conditions=> ['logged_at>=?',"#{@dadidu2}"])
            @selected_date = @dadidu2
        elsif @dadidu!='' && @dadidu2!=''
            #@documents = Document.find(:all, :conditions=> ["letterxdt>=? AND letterxdt<=?","#{@dadidu}","#{@dadidu2}"])
            #@documents = Document.find(:all, :conditions=> ['letterdt=?',"2013-04-01"])  #for testing
            @abababa = StaffAttendance.find(:all,:conditions=> ['logged_at>=? AND logged_at<=?',"#{@dadidu}","#{@dadidu2}"])
            #@staff_attendances = StaffAttendance.find(:all,:conditions=> ['logged_at>=? AND logged_at<=?',"#{@dadidu}","#{@dadidu2}"]).paginate(:per_page => 50, :page => params[:page])
            @selected_date = @dadidu
            @selected_date2 = @dadidu2
        end
        #@document_files = @documents.group_by { |t| t.filedocer }
        #insert above....
      
        #@selected_date = @dadidu #'2012-10-01' #'2012-10-1' 
        @staff_attendances = @abababa#.paginate(:per_page => 100, :page => params[:page])
        @staff_attendance_days = @staff_attendances.group_by {|t| t.group_by_thingy }  

        @ooo = @abababa.group_by {|t| t.group_by_thingy }
        
    #end

    #---if search by date-----------------------------------------------------------------------------------------------------
  else
    #yg asal=============
    @staff_attendances = StaffAttendance.is_controlled.paginate(:per_page => 50, :page => params[:page])    
    @staff_attendance_days = @staff_attendances.group_by {|t| t.group_by_thingy }  
    @ooo = StaffAttendance.is_controlled.group_by {|t| t.group_by_thingy }     
    #yg asal=============
  end
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
    
    if submit_val == "Search by date"
        #set value at above 
        #@selected_date = "2012-10-01"#@dadidu.to_s
        #if @selected_date2!='' && @selected_date !='' #@dadidu!='' && @dadidu2!='' #@selected_date2
          #@days_count = (@selected_date2.to_date-@selected_date.to_date).to_i
          #@next_date = @selected_date
           
        #end
    else
      @selected_date = params[:id]
    end
    if @selected_date.blank?
      @selected_date = "2012-10-16" #default to first page
    end
    
    @selected_rec_by_date=[]
    for testalldeptgroup in @testalldepartmenttgroup
      
        @loop_date = @selected_date
        bil=0
        
        if submit_val == "Search by date" && @dadidu!='' && @dadidu2!=''
          @days_count = ((@dadidu2.to_date )- (@dadidu.to_date)).to_i
          0.upto(1) do |count| 
		          testalldeptgroup.each do |d,k|
		      
				          if d == @loop_date # "2012-10-15" #date
				              @selected_rec_by_date << k
				          end
				    
			        end
			        @loop_date = (@loop_date.to_date.tomorrow.strftime("%Y-%m-%d")).to_s #@selected_date2 #"2012-10-02"#@loop_date.to_date.tomorrow.strftime("%d-%m-%y")
		      end
          
        else
          #0.upto(1) do |count| 
		          testalldeptgroup.each do |d,k|
		      
				          if d == @loop_date # "2012-10-15" #date
				              @selected_rec_by_date << k
				          end
				    
			        end
			        #@loop_date = "2012-10-02"#@loop_date.to_date.tomorrow.strftime("%d-%m-%y")
		      #end
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
