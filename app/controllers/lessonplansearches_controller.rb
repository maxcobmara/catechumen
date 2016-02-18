class LessonplansearchesController < ApplicationController
  filter_access_to :all
  def new
    @loggedinstaff = @current_login.staff_id
    loggedinstaff_roles = @current_login.roles.map(&:name)
    @searchlessonplantype = params[:searchlessonplantype]
    @lessonplansearch = Lessonplansearch.new
    @valid_schedules = WeeklytimetableDetail.valid_sch_ids 
    #ref: lessonplansearch.rb & weeklytimetable_detail.rb - valid weeklytimetable_details is based on valid weeklytimetables(w valid intake)
    #in New just filter once : @valid_schedules
    
    #for programme_id selection
    root_programme_ids = []
    LessonPlan.all.map(&:topic).uniq.each do |x|
        root_programme_ids << Programme.find(x).root_id
    end 
    @programme_list = Programme.find(:all, :conditions=> ['id IN(?)', root_programme_ids.uniq])
    #for intake_id selection
    lessonplans_intake_ids = LessonPlan.all.map(&:intake_id)
    @intake_fr_intaketable = Intake.find(:all, :conditions => ['id IN(?)', lessonplans_intake_ids]).sort_by{|x|[x.programme.course_type, x.programme_id, x.monthyear_intake]}
    
    if loggedinstaff_roles.include?('Administration')
      @lloginstaff=0
      @programme_list = @programme_list 
      @intake_fr_intaketable = @intake_fr_intaketable
    else
      post_kp= Position.find(:first, :conditions => ['staff_id=? and (name ILIKE(?) or tasks_main ILIKE(?) or tasks_other ILIKE(?))', @loggedinstaff, '%Ketua Program%', '%Ketua Program%', '%Ketua Program%'])
      role_kp=Role.find_by_name('Programme Manager').id
      prog_name = Position.find(:first, :conditions => ['staff_id=? and unit is not null', @loggedinstaff]).unit
      if prog_name.strip =='Pos Basik' || prog_name.strip=='Pengkhususan' || prog_name.strip=='Diploma Lanjutan'
        tasks_main=Position.find(:first, :conditions => ['staff_id=?', @loggedinstaff]).tasks_main
        posbasic_prog= Programme.find(:all, :conditions =>['course_type=? OR course_type=? OR course_type=?', 'Pos Basik', 'Pengkhususan', 'Diploma Lanjutan'])
        posbasic_prog.each do |pb|
	  if tasks_main.include?(pb.name)
            @prog_name=pb.name 
	    @prog_id=pb.id
	  end
        end
         prog_id=@prog_id
      else
        prog_id = Programme.find(:first, :conditions => ['name ILIKE(?)', "%#{prog_name.strip}%"]).id
      end
      @programme_list = Programme.find(:all, :conditions => ['id=?', prog_id])
      if (post_kp && (prog_name==@programme_list.first.name)) || (loggedinstaff_roles.include?(role_kp))  #Positions table : 'Ketua Program+Unit', Roles table : 'Programme Manager' only
	@lloginstaff=('999'+prog_id.to_s).to_i
        @intake_fr_intaketable = Intake.find(:all, :conditions => ['id IN(?) and programme_id IN(?)', lessonplans_intake_ids, prog_id]).sort_by{|x|[x.programme.course_type, x.programme_id, x.monthyear_intake]}
      else
        @lloginstaff=@loggedinstaff
        staff_intakes = LessonPlan.find(:all, :conditions => ['lecturer=?', @loggedinstaff]).map(&:intake_id)
        @intake_fr_intaketable = Intake.find(:all, :conditions => ['id IN(?)', staff_intakes]).sort_by{|x|[x.programme.course_type, x.programme_id, x.monthyear_intake]}
      end
    end
  end

  def create
    @searchlessonplantype = params[:method]
    if @searchlessonplantype == '1' || @searchlessonplantype == 1
        @lessonplansearch = Lessonplansearch.new(params[:lessonplansearch])
    end 
    if @lessonplansearch.save
      #flash[:notice] = "Successfully created lessonplansearch."
      redirect_to @lessonplansearch
    else
      render :action => 'new'
    end
  end

  def view_lecturer
    @lessonplansearch = Lessonplansearch.new
    @valid_schedules = WeeklytimetableDetail.valid_sch_ids
    @valid_wtintakes = Weeklytimetable.valid_wt_ids
    @valid_intakes = Weeklytimetable.find(:all, :conditions => ['id IN(?)', @valid_wtintakes]).map(&:intake_id)
    @lecturer_with_exist_lessonplan = LessonPlan.all.map(&:lecturer)
    unless params[:programmeid].blank? && params[:intakeid].blank?
      unless params[:programmeid].blank?
        @programme_id = params[:programmeid].to_i
        @programme_name=Programme.find(@programme_id).name
        intakes_prog = Intake.find(:all, :conditions => ['id IN(?) and programme_id=?', @valid_intakes, @programme_id]).map(&:id)
       @lecturer_prog_with_valid_exist_lessonplan=LessonPlan.find(:all, :conditions => ['lecturer IN(?) and schedule IN(?) and intake_id IN(?)', @lecturer_with_exist_lessonplan, @valid_schedules, intakes_prog]).map(&:lecturer).uniq
      else
        @intake_id = params[:intakeid].to_i
        @programme_id = Intake.find(@intake_id).programme_id
        @programme_name = Programme.find(@programme_id).name
        @lecturer_prog_with_valid_exist_lessonplan=LessonPlan.find(:all, :conditions => ['lecturer IN(?) and schedule IN(?) and intake_id=?', @lecturer_with_exist_lessonplan, @valid_schedules, @intake_id]).map(&:lecturer).uniq
      end
      #@lecturer_list = Staff.find(:all, :conditions =>['id IN(?)', @lecturer_prog_with_valid_exist_lessonplan], :order => 'name ASC')
      ##
      loggedinstaff = @current_login.staff_id
      loggedinstaff_roles = @current_login.roles.map(&:name)
      if loggedinstaff_roles.include?('Administration')
        @lecturer_list = Staff.find(:all, :conditions =>['id IN(?)', @lecturer_prog_with_valid_exist_lessonplan], :order => 'name ASC')
      else
        post_kp = Position.find(:first, :conditions => ['staff_id=? and (name ILIKE(?) or tasks_main ILIKE(?) or tasks_other ILIKE(?))', loggedinstaff, '%Ketua Program%', '%Ketua Program%', '%Ketua Program%'])
	if post_kp
	  @lecturer_list = Staff.find(:all, :conditions =>['id IN(?)', @lecturer_prog_with_valid_exist_lessonplan], :order => 'name ASC')
	else
          @lecturer_list = Staff.find(:all, :conditions =>['id=?', loggedinstaff], :order => 'name ASC')
	end
      end
      ##
    end
    render :partial => 'view_lecturer', :layout => false
  end
  
  def view_subject
    unless params[:lecturerid].blank?
      lecturerid=params[:lecturerid]
      intakeid=params[:intakeid2].to_i
      #@intake2=params[:intakeid2].to_i
      loggedinstaff = @current_login.staff_id
      loggedinstaff_roles = @current_login.roles.map(&:name)
      if loggedinstaff_roles.include?('Administration')
        topics_ids = LessonPlan.find(:all, :conditions =>['lecturer=? and intake_id=?', lecturerid, intakeid]).map(&:topic)
      else
        post_kp = Position.find(:first, :conditions => ['staff_id=? and (name ILIKE(?) or tasks_main ILIKE(?) or tasks_other ILIKE(?))', loggedinstaff, '%Ketua Program%', '%Ketua Program%', '%Ketua Program%'])
        if post_kp
          topics_ids = LessonPlan.find(:all, :conditions =>['lecturer=? and intake_id=?', lecturerid, intakeid]).map(&:topic)
        else
          topics_ids = LessonPlan.find(:all, :conditions => ['lecturer=? and intake_id=?', loggedinstaff,intakeid]).map(&:topic)
        end
      end
      subjects_ids=[]
      for topicid in topics_ids # [377,393,808] 
        ss=Programme.find(topicid).course_type
        subjects_ids << Programme.find(topicid).parent_id if ss=='Topic'
        subjects_ids << Programme.find(topicid).parent.parent_id if ss=='Subtopic'
      end
      @tt=topics_ids
      @ssubjectids=subjects_ids
      @subject_list = Programme.find(:all, :conditions => ['id IN (?)', subjects_ids.uniq])
    end
    render :partial => 'view_subject', :layout => false
  end
  
  def show
    @lessonplansearch = Lessonplansearch.find(params[:id])
  end
end
