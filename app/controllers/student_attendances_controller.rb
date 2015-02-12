class StudentAttendancesController < ApplicationController
   #filter_resource_access
  # GET /student_attendances
  # GET /student_attendances.xml
  def index
    @position_exist = current_login.staff.position
    if @position_exist  
      submit_val = params[:attendance_search]
      classid = params[:classid]
      @intake_student = params[:intake_student] 
      @programme = params[:programme]

      ######==============display classes by current logged-in user only - START
      @programme_list_ids = Programme.roots.map(&:id)    
      @lecturer_programme = current_login.staff.position.unit      #include programme, common subject, 
      unless @lecturer_programme.nil?
        @programme2 = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
      end
    
      #admin
      current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
      @is_admin=true if current_roles.include?("Administration")
    
      #common subject lecturers
      common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan"]
      @common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
      @is_common_lecturer=true if @common_subject_lecturers_ids.include?(Login.current_login.staff_id)
    
      #pengkhususan lecturers
      pengkhususan_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit=? or unit=? or unit=?', "Diploma Lanjutan","Pos Basik", "Pengkhususan"]).map(&:id)
      pengkhususan_lecturers = Staff.find(:all, :conditions=>['id IN(?)', pengkhususan_lecturers_ids],:order=>'name ASC')
      pengkhususan_names = Programme.find(:all, :conditions=> ['course_type=? or course_type=? or course_type=?', "Diploma Lanjutan", "Pos Basik", "Pengkhususan"]).map(&:name)
      if pengkhususan_lecturers_ids.include?(Login.current_login.staff_id)
        @is_pengkhususan_lecturer=true 
        pengkhususan_names.each do |nm|  
          lecturer_tasks_main=Login.current_login.staff.position.tasks_main
          @pengkhususan_name=nm if lecturer_tasks_main.include?(nm)
        end
      end
    
      #retrieve student INTAKES of current logged-in lecturer (not applicable to system admin)
      classes_own_ids = Login.current_login.classes_taughtby     #ids of weeklytimetable_detail   #Cathy Suhaila - [471, 472, 473, 440, 449]
      w_timetable_match = WeeklytimetableDetail.find(:all, :conditions => ['id IN(?)', classes_own_ids]).map(&:weeklytimetable_id).uniq
      ## - w_timetable_match = WeeklytimetableDetail.find(:all, :conditions =>['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id).uniq
      relevant_intakes_ids = Weeklytimetable.find(:all, :conditions => ['id IN(?)', w_timetable_match]).map(&:intake_id)
      relevant_intakes = Intake.find(:all, :conditions => ['id IN(?)', relevant_intakes_ids]).map(&:monthyear_intake) 
      student_intakes = []
      relevant_intakes.each do |ri|
        student_intakes << ri.strftime("%Y-%m-%d")
      end
    
      #set values according to logged-in user
      unless @programme2.nil?
        @preselect_prog= @programme2.id   
        @intake_list2 = Student.find(:all, :conditions => ['course_id=? and intake IN(?)',@preselect_prog, student_intakes], :select=> "DISTINCT intake")
        @student_list = Student.find(:all, :conditions => ['course_id=? and intake IN(?)',@preselect_prog, student_intakes])
        @topics_ids_this_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id) + Programme.find(@preselect_prog).descendants.at_depth(4).map(&:id)
	#below - 2 lines - 12 February 2015
	exist_att_student_ids=StudentAttendance.all.map(&:student_id)
	@intake_list2b=Student.find(:all, :conditions => ['course_id=? and intake IN(?) and id NOT IN(?)',@preselect_prog, student_intakes, exist_att_student_ids], :select=> "DISTINCT intake")
      else 
        if @is_pengkhususan_lecturer
          @preselect_prog=Programme.find_by_name(@pengkhususan_name).id
          @intake_list2 = Student.find(:all, :conditions => ['course_id=? and intake IN(?)',@preselect_prog, student_intakes], :select=> "DISTINCT intake")
          @student_list = Student.find(:all, :conditions => ['course_id=? and intake IN(?)',@preselect_prog, student_intakes])
          @topics_ids_this_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id) + Programme.find(@preselect_prog).descendants.at_depth(4).map(&:id)
        end
      
        #arr for common lecturer & admin
        if @is_common_lecturer || @is_admin
          @intake_course=[]
          @topics_ids_this_prog=[] #must inside here or new array declared with new values for programme lecturers & pengkhususan lecturer
        end
      
        if @is_common_lecturer
          @details2 = WeeklytimetableDetail.find(:all, :conditions=>['lecturer_id=?', Login.current_login.staff_id], :select =>"DISTINCT weeklytimetable_id, topic")
          @details2.each do |d|
            intake_id = Weeklytimetable.find(d.weeklytimetable_id).intake_id
            ii=Intake.find(intake_id).monthyear_intake
            p_id= Programme.find(d.topic).root_id
            p_name=Programme.find(d.topic).root.programme_list
            @intake_course << ["#{ii.to_date.strftime('%b %Y')} | #{p_name}","#{ii}&#{p_id}"]
            @topics_ids_this_prog << d.topic      #all topics & subtopics (common subjects) for all programmes
          end
        end
        if @is_admin
          programme_ids_admin=[]
          @details2 = WeeklytimetableDetail.find(:all, :select =>"DISTINCT weeklytimetable_id, topic")
          @details2.each do |d|
            intake_id = Weeklytimetable.find(d.weeklytimetable_id).intake_id
            ii=Intake.find(intake_id).monthyear_intake
            p_id= Programme.find(d.topic).root_id
            p_name=Programme.find(d.topic).root.programme_list
            @intake_course << ["#{ii.to_date.strftime('%b %Y')} | #{p_name}","#{ii}&#{p_id}"]
            @topics_ids_this_prog << d.topic    #all topics & subtopics (programme subjects+common subjects) for all programmes
            programme_ids_admin << p_id
          end
          student_intakes_admin = Intake.find(Weeklytimetable.find(WeeklytimetableDetail.all.map(&:weeklytimetable_id)).map(&:intake_id)) .map(&:monthyear_intake)
          @intake_list2 = Student.find(:all, :conditions => ['course_id IN(?) and intake IN(?)', programme_ids_admin, student_intakes_admin], :select=> "DISTINCT intake, course_id",:order=>"course_id,intake") 
          @student_list= Student.find(:all, :conditions => ['course_id IN(?) and intake IN(?)',programme_ids_admin, student_intakes_admin],:order=>"course_id,intake") 
        end
      end
      @schedule_list = WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?) and lecturer_id=?',@topics_ids_this_prog, Login.current_login.staff_id]).sort_by{|x|x.get_date_day_of_schedule}
      ######==============display classes by current logged-in user only - END
    
      #assign student attendances values accordingly
      if submit_val == I18n.t("student_attendance.search_class")
        @student_attendances = StudentAttendance.search2(classid)
      else
        unless @intake_student.nil?
          @student_attendances = StudentAttendance.search(@intake_student,@preselect_prog)
        else
          if @is_admin
            @student_attendances = StudentAttendance.all
          else
            @student_attendances = StudentAttendance.find(:all, :conditions=>['weeklytimetable_details_id IN(?)',@schedule_list])
          end
        end
      end

      #group student attendance for listing
      @student_attendances_class = @student_attendances.group_by{|x|x.weeklytimetable_details_id}
      @student_attendances_intake = @student_attendances.group_by{|x|x.student.intake}
    
      #=====retrieve existing student attendance related values for (3) multiple edit by intake(select) - START =====
      #(common subject lecturer, admin & pengkhususan lecturer - @exist_intake_course_attendances)
    
      @exist_attendances = @student_attendances.map(&:weeklytimetable_details_id).uniq 
      @exist_timetable_attendances = WeeklytimetableDetail.find(:all, :conditions=>['id IN (?)', @exist_attendances]).sort_by{|u|u.day_time_slot}

      exist_student = @student_attendances.map(&:student_id)    #must check student intakes as well, or for admin, only programme is checked
      intake_fr_student = Student.find(exist_student).map(&:intake)
    
      unless @programme2.nil?
        @details2b = WeeklytimetableDetail.find(:all, :conditions=>['id IN(?)', @exist_attendances], :select =>"DISTINCT weeklytimetable_id, topic")
      else
        if @is_common_lecturer
          @details2b = WeeklytimetableDetail.find(:all, :conditions=>['lecturer_id=? and id IN(?)', Login.current_login.staff_id, @exist_attendances], :select =>"DISTINCT weeklytimetable_id, topic")
        end
        if @is_admin 
          @details2b = WeeklytimetableDetail.find(:all, :conditions=>['id IN(?)', @exist_attendances], :select =>"DISTINCT weeklytimetable_id, topic")
        end
        if @is_pengkhususan_lecturer
          @details2b = WeeklytimetableDetail.find(:all, :conditions=>['lecturer_id=? and id IN(?)', Login.current_login.staff_id, @exist_attendances], :select =>"DISTINCT weeklytimetable_id, topic")
        end
      end
    
      @exist_intake_course_attendances=[]
      course_ids=[]
      intakess=[]
      @details2b.each do |d|
        intake_id = Weeklytimetable.find(d.weeklytimetable_id).intake_id
        ii=Intake.find(intake_id).monthyear_intake
        if intake_fr_student.include?(ii)
          p_id= Programme.find(d.topic).root_id
          p_name=Programme.find(d.topic).root.programme_list
          course_ids << p_id
          intakess << ii
          @exist_intake_course_attendances << ["#{ii.to_date.strftime('%b %Y')} | #{p_name}","#{ii}&#{p_id}"]
        end
      end
      @exist_intake = Student.find(:all, :conditions => ['course_id IN(?) and intake IN(?)', course_ids, intakess], :select=> "DISTINCT intake")
      #=====retrieve existing student attendance related values for (3) multiple edit by intake(select) - END =====
    
      #===(3) multiple edit by intake  (programme lecturer - @intatake2)  & (4) SEARCH by intake (for all logged-in user)===START
      @intatake = [] 
      @student_attendances_intake.each do |intake, student_attendances|
        @intatake << intake 
      end 
      @students = @student_attendances.map(&:student_id).uniq 
      @courses = Student.find(@students).map(&:course_id).uniq 
      unless @programme2.nil?                       
        @intatake2 = Student.find(:all, :conditions => ['course_id=? AND intake IN (?)',@preselect_prog, @intatake], :select=> "DISTINCT intake") 
      else
        #differentiate SEARCH by intake (item) accordingly
        #for Common Subject's lecturer, whenever same intake exist for multiple programmes, just display Intake once
        if @is_common_lecturer 
          @intatake2 = Student.find(:all, :conditions => ['intake IN(?)', @intatake], :select => "DISTINCT intake")
        else #admin & pengkhususan lecturers
          @intatake2 = Student.find(:all, :conditions => ['course_id IN (?) AND intake IN (?)',@courses, @intatake], :select=> "DISTINCT intake,course_id") 
        end
      end 
      #===(3) multiple edit by intake  (programme lecturer - @intatake2)  & (4) SEARCH by intake (for all logged-in user)===END

      #for (2) multiple new by class
      @schedule_list2 = @schedule_list - @exist_timetable_attendances
    
      #for (1) multiple new by intake+programme for common lecturer & admin
      @intake_course2 = @intake_course - @exist_intake_course_attendances if @programme2.nil? && !@is_pengkhususan_lecturer 
    
      #####DEFAULT - REQUIRED - 12 February 2015
      #for (1) multiple new by intake for programme lecturers(diploma, pengkhususan) 
      @intake_list2b = @intake_list2 - @exist_intake if !@is_common_lecturer && @exist_intake.count == 0
    
    end  
    respond_to do |format|
      if @position_exist
        format.html # index.html.erb
        format.xml  { render :xml => @student_attendances }
      else
        format.html {redirect_to "/home", :notice =>t('position_required')+t('student_attendance.title')}
        format.xml  { render :xml => @student_attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /student_attendances/1
  # GET /student_attendances/1.xml
  def show
    @student_attendance = StudentAttendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_attendance }
    end
  end

  # GET /student_attendances/new
  # GET /student_attendances/new.xml
  def new
    @new_type = params[:new_type]
    
    ####from index-start##############################################
    @lecturer_programme = current_login.staff.position.unit
    unless @lecturer_programme.nil?
      @programme2 = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end

    #admin
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
    @is_admin=true if current_roles.include?("Administration")

    #common subject lecturers
    common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan"]
    @common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
    @is_common_lecturer=true if @common_subject_lecturers_ids.include?(Login.current_login.staff_id)
      
    #pengkhususan lecturers
    pengkhususan_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit=? or unit=? or unit=?', "Diploma Lanjutan","Pos Basik", "Pengkhususan"]).map(&:id)
    pengkhususan_lecturers = Staff.find(:all, :conditions=>['id IN(?)', pengkhususan_lecturers_ids],:order=>'name ASC')
    pengkhususan_names = Programme.find(:all, :conditions=> ['course_type=? or course_type=? or course_type=?', "Diploma Lanjutan", "Pos Basik", "Pengkhususan"]).map(&:name)
    if pengkhususan_lecturers_ids.include?(Login.current_login.staff_id)
      @is_pengkhususan_lecturer=true 
      pengkhususan_names.each do |nm|  
        lecturer_tasks_main=Login.current_login.staff.position.tasks_main
        @pengkhususan_name=nm if lecturer_tasks_main.include?(nm)
      end
    end
    
    #retrieve student INTAKES of current logged-in lecturer (not applicable to system admin)
    classes_own_ids = Login.current_login.classes_taughtby     #ids of weeklytimetable_detail
    w_timetable_match = WeeklytimetableDetail.find(:all, :conditions => ['id IN(?)', classes_own_ids]).map(&:weeklytimetable_id).uniq
    ## - w_timetable_match = WeeklytimetableDetail.find(:all, :conditions =>['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id).uniq
    relevant_intakes_ids = Weeklytimetable.find(:all, :conditions => ['id IN(?)', w_timetable_match]).map(&:intake_id)
    relevant_intakes = Intake.find(:all, :conditions => ['id IN(?)', relevant_intakes_ids]).map(&:monthyear_intake) 
    student_intakes = []
    relevant_intakes.each do |ri|
      student_intakes << ri.strftime("%Y-%m-%d")
    end

    #set values according to logged-in user
    unless @programme2.nil?
      @preselect_prog= @programme2.id     #@preselect_prog (programme_id)
      @student_list = Student.find(:all, :conditions => ['course_id=? and intake IN(?)',@preselect_prog, student_intakes])
      @topics_ids_this_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id) + Programme.find(@preselect_prog).descendants.at_depth(4).map(&:id)
    else  
      if @is_pengkhususan_lecturer
        @preselect_prog=Programme.find_by_name(@pengkhususan_name).id
        @topics_ids_this_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id) + Programme.find(@preselect_prog).descendants.at_depth(4).map(&:id)
      end
      #if @is_common_lecturer
      #end
      if @is_admin
        @intake_list2 = Student.find(:all, :conditions => ['course_id IN(?) and intake IN(?)',@programme_list_ids, student_intakes], :select=> "DISTINCT intake, course_id",:order=>"course_id,intake") 
        @student_list= Student.find(:all, :conditions => ['course_id IN(?) and intake IN(?)',@programme_list_ids, student_intakes],:order=>"course_id,intake") 
        @topics_ids_this_prog = Programme.at_depth(3)+Programme.at_depth(4).map(&:id)
      end
    end
    @schedule_list = WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?) and lecturer_id=?',@topics_ids_this_prog, Login.current_login.staff_id])
    ####from index-end##############################################
    
    if @new_type && @new_type == "1"
      @student_attendance = StudentAttendance.new(params[:student_attendance]) 
    elsif @new_type && @new_type == "2"
      @classid = params["classid"]
      @student_attendances = Array.new(5) { StudentAttendance.new } 	        
    elsif @new_type && @new_type == "3"
      unless params["intake"].nil?
        @intake = params["intake"]
      else
        intake_prog = params["intake_prog"]
        @intake = intake_prog.split("&")[0]
        @preselect_prog = intake_prog.split("&")[1]
        topics_of_selected_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id)
        subtopics_of_selected_prog = Programme.find(@preselect_prog).descendants.at_depth(4).map(&:id)
        @topics_ids_this_prog = topics_of_selected_prog+subtopics_of_selected_prog
        
        #duplicate  line 266 1st (for @schedule_list values)
        if @is_common_lecturer || @is_pengkhususan_lecturer
          @schedule_list=WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?) and lecturer_id=?',@topics_ids_this_prog, Login.current_login.staff_id])
        end
        if @is_admin
          @schedule_list=WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?)', @topics_ids_this_prog])
        end

      end
      #working sample : nurussaadah(radiografi) & halimah(kebidanan), single/multiple classes of multiple intakes-Start
      wtimetable_ids=@schedule_list.map(&:weeklytimetable_id) 
      intakes_count = Weeklytimetable.find(:all, :conditions => ['id IN(?)', wtimetable_ids]).map(&:intake_id).uniq.count
      if intakes_count > 1
        class_ids =@schedule_list.map(&:id) 
        intake_id=Intake.find(:first, :conditions => ['monthyear_intake=? and programme_id=?', @intake,@preselect_prog]).id
        wtimetable_of_intake = Weeklytimetable.find(:all, :conditions => ['id IN(?) and intake_id=?',wtimetable_ids, intake_id]).map(&:id) 
        classes_of_intake = WeeklytimetableDetail.find(:all, :conditions => ['weeklytimetable_id in(?) AND id IN(?)', wtimetable_of_intake, class_ids])
        @schedule_list = classes_of_intake
      end
      #working sample : nurussaadah(radiografi) & halimah(kebidanan), single/multiple classes of multiple intakes-End
      
      @student_attendances = Array.new(5) { StudentAttendance.new }                 
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_attendance }
    end
  end

  # GET /student_attendances/1/edit
  def edit
    @student_attendance = StudentAttendance.find(params[:id])
    ####from index-start##############################################
    @lecturer_programme = current_login.staff.position.unit
    unless @lecturer_programme.nil?
      @programme2 = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end

    #admin
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
    @is_admin=true if current_roles.include?("Administration")
    
    #common subject lecturers
    common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan"]
    @common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
    @is_common_lecturer=true if @common_subject_lecturers_ids.include?(Login.current_login.staff_id)
    
    #pengkhususan lecturers
    pengkhususan_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit=? or unit=? or unit=?', "Diploma Lanjutan","Pos Basik", "Pengkhususan"]).map(&:id)
    pengkhususan_lecturers = Staff.find(:all, :conditions=>['id IN(?)', pengkhususan_lecturers_ids],:order=>'name ASC')
    pengkhususan_names = Programme.find(:all, :conditions=> ['course_type=? or course_type=? or course_type=?', "Diploma Lanjutan", "Pos Basik", "Pengkhususan"]).map(&:name)
    if pengkhususan_lecturers_ids.include?(Login.current_login.staff_id)
      @is_pengkhususan_lecturer=true 
      pengkhususan_names.each do |nm|  
        lecturer_tasks_main=Login.current_login.staff.position.tasks_main
        @pengkhususan_name=nm if lecturer_tasks_main.include?(nm)
      end
    end
    
    #retrieve student INTAKES of current logged-in lecturer (not applicable to system admin)
    classes_own_ids = Login.current_login.classes_taughtby     #ids of weeklytimetable_detail
    w_timetable_match = WeeklytimetableDetail.find(:all, :conditions => ['id IN(?)', classes_own_ids]).map(&:weeklytimetable_id).uniq
    ## - w_timetable_match = WeeklytimetableDetail.find(:all, :conditions =>['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id).uniq
    relevant_intakes_ids = Weeklytimetable.find(:all, :conditions => ['id IN(?)', w_timetable_match]).map(&:intake_id)
    relevant_intakes = Intake.find(:all, :conditions => ['id IN(?)', relevant_intakes_ids]).map(&:monthyear_intake) 
    student_intakes = []
    relevant_intakes.each do |ri|
      student_intakes << ri.strftime("%Y-%m-%d")
    end

    #set values according to logged-in user
    unless @programme2.nil?
      @preselect_prog= @programme2.id     #@preselect_prog (programme_id)
      @student_list = Student.find(:all, :conditions => ['course_id=? and intake IN(?)',@preselect_prog, student_intakes])
      @topics_ids_this_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id)
    else 
      if @is_pengkhususan_lecturer
        @preselect_prog=Programme.find_by_name(@pengkhususan_name).id
        @student_list = Student.find(:all, :conditions => ['course_id=? and intake IN(?)',@preselect_prog, student_intakes])
        @topics_ids_this_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id)
      end
      if @is_common_lecturer
        @details2 = WeeklytimetableDetail.find(:all, :conditions=>['lecturer_id=?', Login.current_login.staff_id], :select =>"DISTINCT weeklytimetable_id, topic")
        @topics_ids_this_prog=[]
        @details2.each do |d|
          @topics_ids_this_prog << d.topic #all accessible prog
        end
        schedule_id = @student_attendance.weeklytimetable_details_id
        w_timetable = WeeklytimetableDetail.find(schedule_id).weeklytimetable_id
        intakeid = Weeklytimetable.find(w_timetable).intake_id
        intake = Intake.find(intakeid).monthyear_intake
        thistopic = WeeklytimetableDetail.find(schedule_id).topic
        courseid = Programme.find(thistopic).root_id
        @student_list=Student.find(:all, :conditions=>['course_id=? and intake=?', courseid, intake])
      end
      if @is_admin
        @student_list= Student.find(:all, :conditions => ['course_id IN(?) and intake IN(?)',@programme_list_ids, student_intakes],:order=>"course_id,intake") 
        @topics_ids_this_prog = Programme.at_depth(3).map(&:id)+Programme.at_depth(4).map(&:id)
      end
    end
    @schedule_list = WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?) and lecturer_id=?',@topics_ids_this_prog, Login.current_login.staff_id])
    ####from index-end##############################################
  end

  # POST /student_attendances
  # POST /student_attendances.xml
  def create
    @create_type = params[:new_submit]                                            
    if @create_type == I18n.t('create')     #create single record                                               
      @new_type = "1"
      @student_attendance = StudentAttendance.new(params[:student_attendance])
      respond_to do |format|
        if @student_attendance.save
          format.html { redirect_to(@student_attendance, :notice => t('student_attendance.title')+" "+t('created')) }
          format.xml  { render :xml => @student_attendance, :status => :created, :location => @student_attendance }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @student_attendance.errors, :status => :unprocessable_entity }
        end
      end
    elsif @create_type == I18n.t('student_attendance.create_class_schedule')    #create multiple record (by class)
      @new_type = "2"
      @student_attendances_all = params[:student_attendances]  
      @student_attendances = params[:student_attendances].values.collect {|student_attendance| StudentAttendance.new(student_attendance) }
      if @student_attendances.all?(&:valid?) 
        @student_attendances.each(&:save!)  # ref: to retrieve each value of @exammarks --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
        flash[:notice] = I18n.t("saved_all_records")
        redirect_to :action => 'index'
      else                                                                                        
        flash[:error] = I18n.t('student_attendance.data_invalid')
        render :action => 'new'
        flash.discard
      end    
    elsif @create_type == I18n.t('student_attendance.create_intake')     #create multiple record (by intake)
      @new_type = "3"
      @student_attendances_all = params[:student_attendances]  
      @student_attendances = params[:student_attendances].values.collect {|student_attendance| StudentAttendance.new(student_attendance) }
      if @student_attendances.all?(&:valid?) 
        @student_attendances.each(&:save!)  # ref: to retrieve each value of @exammarks --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
        #flash[:notice] = 'Successfully saved all records'
        #params[:student_attendance_ids] = [82,83,84,85,86,87] -testing OK
        flash[:notice] = I18n.t('student_attendance.confirm_complete_attendance')
        params[:student_attendance_ids] = @student_attendances.map(&:id)
        render :action => "edit_multiple_intake"
        flash.discard
      else                         
        flash[:error] = 'Data supplied was invalid.'
        render :action => 'new'
        flash.discard
      end
    end
  end

  # PUT /student_attendances/1
  # PUT /student_attendances/1.xml
  def update
    @student_attendance = StudentAttendance.find(params[:id])

    respond_to do |format|
      if @student_attendance.update_attributes(params[:student_attendance])
        format.html { redirect_to(@student_attendance, :notice => t('student_attendance.title')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student_attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /student_attendances/1
  # DELETE /student_attendances/1.xml
  def destroy
    @student_attendance = StudentAttendance.find(params[:id])
    @student_attendance.destroy

    respond_to do |format|
      format.html { redirect_to(student_attendances_url) }
      format.xml  { head :ok }
    end
  end

  def edit_multiple_intake
    @edit_type = params[:student_attendance_intake]
    if @edit_type == I18n.t("student_attendance.edit_multiple_intake")
      #@intake = params[:intake_student]
       
      ####from index-start##############################################
      #admin
      current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
      @is_admin=true if current_roles.include?("Administration")
       
      #common subject lectureres
      common_subjects = ["Sains Perubatan Asas", "Anatomi & Fisiologi", "Sains Tingkahlaku", "Komunikasi & Sains Pengurusan"]
      @common_subject_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit IN(?)', common_subjects]).map(&:id)
      @is_common_lecturer=true if @common_subject_lecturers_ids.include?(Login.current_login.staff_id)
      
      #pengkhususan lecturers
      pengkhususan_lecturers_ids = Staff.find(:all, :joins=>:position, :conditions=>['unit=? or unit=? or unit=?', "Diploma Lanjutan","Pos Basik", "Pengkhususan"]).map(&:id)
      pengkhususan_lecturers = Staff.find(:all, :conditions=>['id IN(?)', pengkhususan_lecturers_ids],:order=>'name ASC')
      pengkhususan_names = Programme.find(:all, :conditions=> ['course_type=? or course_type=? or course_type=?', "Diploma Lanjutan", "Pos Basik", "Pengkhususan"]).map(&:name)
      if pengkhususan_lecturers_ids.include?(Login.current_login.staff_id)
        @is_pengkhususan_lecturer=true 
        pengkhususan_names.each do |nm|  
          lecturer_tasks_main=Login.current_login.staff.position.tasks_main
          @pengkhususan_name=nm if lecturer_tasks_main.include?(nm)
        end
      end
      ####from index-end##############################################
 
      #===Group student attandances by INTAKE===start
      #programme lecturers ONLY
      unless params["intake_student"].nil?
          @intake = params["intake_student"]
          @student_attendances_intake = StudentAttendance.all.group_by{|x|x.student.intake.strftime("%Y-%m-%d")}
      end
      
      #common subject lecturers / admin / pengkhususan lectures
      if params["intake_prog"] && (@is_admin || @is_common_lecturer || @is_pengkhususan_lecturer)
        intake_prog = params["intake_prog"]
        @intake = intake_prog.split("&")[0]
        @preselect_prog = intake_prog.split("&")[1]
        topics_of_selected_prog = Programme.find(@preselect_prog).descendants.at_depth(3).map(&:id)
        subtopics_of_selected_prog = Programme.find(@preselect_prog).descendants.at_depth(4).map(&:id)
        common_topics =[]
        other_topics=[]
        @topics_ids_this_prog = topics_of_selected_prog+subtopics_of_selected_prog
        topics_of_selected_prog.each do |x|
          common_topics << x if Programme.find(x).parent.course_type=="Commonsubject"
          other_topics << x if Programme.find(x).parent.course_type=="Subject"
        end
        subtopics_of_selected_prog.each do |x|
          common_topics << x if Programme.find(x).parent.parent.course_type=="Commonsubject"
          other_topics << x if Programme.find(x).parent.parent.course_type=="Subject"
        end

        if @is_pengkhususan_lecturer
          @schedule_list=WeeklytimetableDetail.find(:all, :conditions=>['topic IN(?) and lecturer_id=?', other_topics, Login.current_login.staff_id])
        end
        if @is_common_lecturer
          @schedule_list=WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?) and lecturer_id=?',common_topics, Login.current_login.staff_id])
        end
        if @is_admin#admin
          programme_lecturer = Position.find(:all, :joins=>:staff, :conditions=>['unit=?',Programme.find(@preselect_prog).name]).map(&:staff_id)
          @schedule_list=WeeklytimetableDetail.find(:all, :conditions => ['topic IN(?) or topic IN(?)',other_topics, common_topics])
        end
        @student_attendances_intake = StudentAttendance.find(:all, :conditions=>['weeklytimetable_details_id IN(?)',@schedule_list.map(&:id)]).group_by{|x|x.student.intake.strftime("%Y-%m-%d")}
      end
      #===Group student attandances by INTAKE===end
      #@student_attendances_intake = StudentAttendance.all.group_by{|x|x.student.intake.strftime("%Y-%m-%d")} 
      
      #==For each intake, if MATCHED with selected intake(param values), collect attendance IDs accordingly
      #@ab=[] - for checking only
      @studentattendance_ids = []
      @student_attendances_intake.each do |intake,sa|
        #@ab << intake
        if intake == @intake#  "2008-01-01"
          @studentattendance_ids = sa.map(&:id)#[4781,4782,4783,4784,4785,4786]
        end
      end 
      #@studentattendance_ids = [4779, 4780]
      #@studentattendance_ids = [4781,4782,4783,4784,4785,4786]
      #@studentattendance_ids = StudentAttendance#params[:student_attendance_ids]
      
      #==Display selected records for multiple edit (by selected intake(+prog))
      unless @studentattendance_ids.blank? 
        @studentattendances = StudentAttendance.find(@studentattendance_ids)
        @student_count = @studentattendances.map(&:student_id).uniq.count
        @edit_type = params[:student_attendance_submit_button]  
      else    
        flash[:notice] = I18n.t("student_attendance.select_intake_edit")+@intake.to_s+"-"+@ab.to_s+"~"+@student_attendances_intake.count.to_s
        redirect_to student_attendances_path
      end
    end
  end    #--end of multiple edit by intake

  def edit_multiple
    @studentattendance_ids = params[:student_attendance_ids]
    unless @studentattendance_ids.blank? 
      @studentattendances = StudentAttendance.find(@studentattendance_ids)
      @studentattendances_group = @studentattendances.group_by{|x|x.student_id}    
      @time_slot_main_count = @studentattendances.group_by{|u|u.weeklytimetable_detail.get_time_slot}.count
      @studentattendances_group.each do |s,sa|
        @time_slot_each_count = sa.group_by{|u|u.weeklytimetable_detail.get_time_slot}.count 
        if @time_slot_each_count != @time_slot_main_count
          @time_slot_match ="no"
        end
      end
        
      if ((@studentattendances.count % @studentattendances_group.count) == 0) 
        if (@time_slot_match =="no")
          flash[:notice] = I18n.t('student_attendance.same_class')
          redirect_to student_attendances_path
        else
          if @time_slot_main_count > 3
            flash[:notice] = I18n.t('student_attendance.max_time_slot')
            redirect_to student_attendances_path
          else
            @student_count = @studentattendances.map(&:student_id).uniq.count
            @edit_type = params[:student_attendance_submit_button] 
          end
        end
      else 
        flash[:notice] = I18n.t('student_attendance.student_must_identical')
        redirect_to student_attendances_path
      end
    else    
      flash[:notice] = I18n.t('student_attendance.select_one')
      redirect_to student_attendances_path
    end
  end    #--end of multiple edit 
  
  def update_multiple
    submit_val = params[:applychange]
    @studentattendance_ids = params[:student_attendance_ids]	
    @attends = params[:attends] 
    @reasons = params[:reasons]
    @actions = params[:actions]
    @statuss = params[:statuss]
    @remarks = params[:remarks]
    @weeklytimetable_details_ids = params[:weeklytimetable_details_ids]
    @studentattendances = StudentAttendance.find(@studentattendance_ids)  
    @studentattendances_group = @studentattendances.group_by{|x|x.student_id} 
 
    if submit_val == I18n.t('student_attendance.apply_class_schedule')
      if @weeklytimetable_details_ids != nil
        @studentattendances_group.each do |student_id, studentattendances|  
          studentattendances.each_with_index do |studentattendance, no|
            studentattendance.weeklytimetable_details_id = @weeklytimetable_details_ids[no.to_s]
            studentattendance.save
          end
        end
      end

      respond_to do |format|
        flash[:notice] = "<b>#{(t 'student_attendance.class_schedule')}</b> #{(t 'student_attendance.selected_may_print')} <b>#{(t 'student_attendance.attendance_form')}</b>#{t('student_attendance.cw_date_timeslot')}<br>#{t('student_attendance.to_update')}<b>#{t('student_attendance.title').downcase}</b>#{t('student_attendance.check_uncheck_click')}<b>#{t('submit')}</b>."
        format.html {render :action => "edit_multiple_intake"}
        format.xml  { head :ok }
        flash.discard
      end
    else
      #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      #start-for edit_multiple.html.erb--------
      if !@weeklytimetable_details_ids
        @next2 = 0
        @sa_sort_then_group = @studentattendances.sort_by{|y|y.student.name}.group_by{|x|x.student_id} 
        @sa_sort_then_group.each do |student_id, studentattendances| 
          studentattendances.sort_by{|u|u.weeklytimetable_detail.get_time_slot}.each_with_index do |studentattendance, no2|
            if @attends && @attends[(no2+@next2).to_s]!=nil
              studentattendance.attend = true
            else
              studentattendance.attend = false
              if @reasons && @reasons[(no2+@next2).to_s] != nil
                studentattendance.reason = @reasons[(no2+@next2).to_s]
                studentattendance.action = @actions[(no2+@next2).to_s]
                studentattendance.status = @statuss[(no2+@next2).to_s]
                studentattendance.remark = @remarks[(no2+@next2).to_s]
              end
            end
            studentattendance.save 
            if no2 == studentattendances.count-1 #2 
              @next2 = @next2+no2+1 
            end
          end  
        end
      end
      #end-for edit_multiple.html.erb--------
      #start-for edit_multiple_intake.html.erb--------
      @next = 0
      if @weeklytimetable_details_ids != nil
        @studentattendances_group.each do |student_id, studentattendances|  
          studentattendances.each_with_index do |studentattendance, no|
            studentattendance.weeklytimetable_details_id = @weeklytimetable_details_ids[no.to_s]
            if @attends && @attends[(no+@next).to_s]!=nil   #if @attends && @attends[no.to_s]!=nil
              studentattendance.attend = true
            else
              studentattendance.attend = false
            end
            studentattendance.save 
            if no == studentattendances.count-1 #2 
              @next = @next+no+1 
            end 
          end
        end
      end
      #end-for edit_multiple_intake.html.erb--------
  
      flash[:notice] = I18n.t('student_attendance.updated_attendance')
      redirect_to student_attendances_path
      #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    end
  end   #--end of def update_multiple
   
  def borang_kehadiran
      @studentattendance_ids = params[:iddd]    #[628,629,630,631,632,633]
      @first = params[:first].to_i
      @form_type = params[:form_type]
      @student_attendances = StudentAttendance.find(:all, :conditions => ['id IN (?)',@studentattendance_ids])
      
      if (@student_attendances[0].weeklytimetable_details_id != nil) && (@student_attendances[@student_attendances.count-1].weeklytimetable_details_id != nil)
          @student_attendances = @student_attendances.sort_by{|u|u.weeklytimetable_detail.day_time_slot}
      elsif (@student_attendances[0].weeklytimetable_details_id != nil) && (@student_attendances[@student_attendances.count-1].weeklytimetable_details_id == nil)
          @student_attendancesA = StudentAttendance.find(:all, :conditions => ['id IN (?) AND weeklytimetable_details_id IS NOT NULL',@studentattendance_ids]).sort_by{|u|u.weeklytimetable_detail.day_time_slot}
          @student_attendancesB = StudentAttendance.find(:all, :conditions => ['id IN (?) AND weeklytimetable_details_id IS NULL',@studentattendance_ids])
          @student_attendances = @student_attendancesA+@student_attendancesB
      end
      #@student_attendances = StudentAttendance.find(:all, :conditions => ['id IN (?)',@studentattendance_ids]).sort_by{|u|u.weeklytimetable_detail.get_time_slot}
      @studentattendances_group = @student_attendances.sort_by{|x|x.student.name}.group_by{|x|x.student_id} #sort first than group!
      render :layout => 'report'
  end
 
end
