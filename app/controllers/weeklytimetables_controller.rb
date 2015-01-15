class WeeklytimetablesController < ApplicationController
  # GET /weeklytimetables
  # GET /weeklytimetables.xml
  def index
    @position_exist = current_login.staff.position
    if @position_exist  
      @lecturer_programme = current_login.staff.position.unit
      unless @lecturer_programme.nil?
        @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
      end 
      unless @programme.nil?     #works for both Admin & Pengajar SUBJEK ASAS
        @programme_id = @programme.id 
      end
      #note - restriction : refer authorization rules
      #note - Weeklytimetable listing : based on @programme_id value being sent to 'search' method in staff.rb
      @weeklytimetables = Weeklytimetable.with_permissions_to(:index).search(@programme_id) 
      
      common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan"]
      @common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
      current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
      @is_admin=true if current_roles.include?("Administration")
      @is_common_lecturer=true if @common_subject_lecturers_ids.include?(Login.current_login.staff_id)

    end
    respond_to do |format|
      if @position_exist
        format.html # index.html.erb
        format.xml  { render :xml => @weeklytimetables }
      else
        format.html {redirect_to "/home", :notice =>t('position_required')+t('weeklytimetable.title2')}
        format.xml  { render :xml => @weeklytimetable.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def personalize_index
    @weeklytimetables_details=WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?',Login.current_login.staff_id])

    respond_to do |format|
      format.html { render :action => "personalize_index" }
      format.xml  { render :xml => @weeklytimetables }
    end
  end

  # GET /weeklytimetables/1
  # GET /weeklytimetables/1.xml
  def show
    @weeklytimetable = Weeklytimetable.find(params[:id])

    common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan"]
    @common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
    @is_admin=true if current_roles.include?("Administration")
    @is_common_lecturer=true if @common_subject_lecturers_ids.include?(Login.current_login.staff_id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weeklytimetable }
    end
  end
  
  def personalize_show  #yg dihantar : startdate
    @selected_date = params[:id]
    @weeklytimetables_details=WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?',Login.current_login.staff_id])
    @all_combine = []
    @weeklytimetables_details.each do |x|
        @all_combine << Weeklytimetable.find(x.weeklytimetable.id)
    end 
    @personalize = @all_combine.group_by{|t|t.startdate}
  end
  
  # GET /weeklytimetables/new
  # GET /weeklytimetables/new.xml
  def new
    @weeklytimetable = Weeklytimetable.new
    #@weeklytimetable.weeklytimetable_details.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weeklytimetable }
    end
  end

  # GET /weeklytimetables/1/edit
  def edit
    @weeklytimetable = Weeklytimetable.find(params[:id])
    prog_name = Programme.find(@weeklytimetable.programme_id).name
    
    common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan"]
    common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
    pengkhususan_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['(unit=? or unit=? or unit=?) and tasks_main ILIKE(?)', "Diploma Lanjutan","Pos Basik", "Pengkhususan", "%#{prog_name}%"]).map(&:id)
      
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
    
    @programme_lecturers = Staff.find(:all, :joins=>:position, :conditions=>['positions.name=? AND positions.unit=?','Pengajar',Programme.find(@weeklytimetable.programme_id).name],:order=>'name ASC')
    @commonsubject_lecturers = Staff.find(:all, :conditions=>['id IN(?)', common_subject_lecturers_ids],:order=>'name ASC')
    @pengkhususan_lecturers = Staff.find(:all, :conditions=>['id IN(?)', pengkhususan_lecturers_ids],:order=>'name ASC')
    
    @is_admin=true if current_roles.include?("Administration")
    @is_common_lecturer=true if common_subject_lecturers_ids.include?(Login.current_login.staff_id)
    @is_prog_lecturer=true if @programme_lecturers.map(&:id).include?(Login.current_login.staff_id)
    @is_pengkhususan_lecturer=true if pengkhususan_lecturers_ids.include?(Login.current_login.staff_id)
  end

  # POST /weeklytimetables
  # POST /weeklytimetables.xml
  def create
    @weeklytimetable = Weeklytimetable.new(params[:weeklytimetable])

    respond_to do |format|
      if @weeklytimetable.save
        format.html { redirect_to(@weeklytimetable, :notice =>t('weeklytimetable.title2')+" "+t('created')) }
        format.xml  { render :xml => @weeklytimetable, :status => :created, :location => @weeklytimetable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weeklytimetable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weeklytimetables/1
  # PUT /weeklytimetables/1.xml
  def update
    #raise params.inspect

    @weeklytimetable = Weeklytimetable.find(params[:id])
    
    respond_to do |format|
      if @weeklytimetable.update_attributes(params[:weeklytimetable])
        format.html { redirect_to(@weeklytimetable, :notice => t('weeklytimetable.title2')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weeklytimetable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weeklytimetables/1
  # DELETE /weeklytimetables/1.xml
  def destroy
    @weeklytimetable = Weeklytimetable.find(params[:id])
    @weeklytimetable.destroy

    respond_to do |format|
      format.html { redirect_to(weeklytimetables_url) }
      format.xml  { head :ok }
    end
  end
  
  #23March2013
  def general_timetable
    @weeklytimetable = Weeklytimetable.find(params[:id])
    render :layout => 'report'
  end
  
  def personalize_timetable
    @selected_date = params[:id]
    #---start:added-26Jul2013-for e-query & report manager--
    if @selected_date
    else
        @hihi = params[:locals][:id]
        @haha = params[:locals][:lecturer_id]
    end
    #---end:added-26Jul2013-for e-query & report manager--
    @weeklytimetables_details=WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?',Login.current_login.staff_id])
    #---start:added-26Jul2013-for e-query & report manager--
    if @hihi!=nil
        @selected_date = @hihi
        @weeklytimetables_details=WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?',@haha.to_i])
    end
    #---end:added-26Jul2013-for e-query & report manager--
    @all_combine = []
    @weeklytimetables_details.each do |x|
        @all_combine << Weeklytimetable.find(x.weeklytimetable_id)  #Weeklytimetable.find(x.weeklytimetable.id)
    end 
    @personalize = @all_combine.group_by{|t|t.startdate}
    render :layout => 'report'
  end
  
end
