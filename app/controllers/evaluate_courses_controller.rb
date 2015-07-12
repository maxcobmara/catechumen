class EvaluateCoursesController < ApplicationController
  # GET /evaluate_courses
  # GET /evaluate_courses.xml
  #filter_resource_access
  filter_access_to :all
  def index
    #@evaluate_courses = EvaluateCourse.all
    
    unless current_login.isstaff==true
      @programme=Programme.find(:first, :conditions => ['id=?', Student.find(current_login.student_id).course_id])
      if params[:search]
        @evaluate_courses = EvaluateCourse.with_permissions_to(:index).search2(@programme.id, params[:search])
      else
        @evaluate_courses = EvaluateCourse.with_permissions_to(:index).search(@programme.id)
      end
    else
      @position_exist = current_login.staff.position
      if @position_exist     
        @lecturer_programme = current_login.staff.position.unit
        unless @lecturer_programme.nil?
          @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
        end
        unless @programme.nil?
          if params[:search]
            @evaluate_courses = EvaluateCourse.with_permissions_to(:index).search2(@programme.id, params[:search])
          else
            @evaluate_courses = EvaluateCourse.with_permissions_to(:index).search(@programme.id)
          end
        else
          if @lecturer_programme == 'Commonsubject'
          else
            if params[:search]
              @evaluate_courses = EvaluateCourse.with_permissions_to(:index).search3(params[:search])
            else
              @evaluate_courses = EvaluateCourse.with_permissions_to(:index).sort_by{|x|[x.staff_id, x.subject_id]}
            end
          end
        end
      end 
    end

    respond_to do |format|
      if (@position_exist && current_login.isstaff==true) || current_login.isstaff==false
        format.html # index.html.erb
        format.xml  { render :xml => @evaluate_courses}
      else
        format.html {redirect_to "/home", :notice =>t('position_required')+t('evaluate_course.title2')}
        format.xml  { render :xml => @evaluate_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /evaluate_courses/1
  # GET /evaluate_courses/1.xml
  def show
    @evaluate_course = EvaluateCourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evaluate_course }
    end
  end

  # GET /evaluate_courses/new
  # GET /evaluate_courses/new.xml
  def new
    @evaluate_course = EvaluateCourse.new
    unless current_login.isstaff==true
      @studentid=current_login.student_id
      @programme=Programme.find(:first, :conditions => ['id=?', Student.find(@studentid).course_id]) 
    else
      @lecturer_programme = current_login.staff.position.unit
    end
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_list = Programme.find(:all, :conditions=>['id IN (?)',Array(@programme.id)])
      @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
      @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
      @subjectlist_preselect_prog = Programme.find(@programme.id).descendants.at_depth(2).sort_by(&:ancestry)
      @preselect_prog = @programme.id
    else
      if @lecturer_programme == 'Commonsubject'
      else
        @programme_list = Programme.roots
        @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
        @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
        @subjectlist_preselect_prog = Programme.at_depth(2)
      end
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evaluate_course }
    end
  end

  # GET /evaluate_courses/1/edit
  def edit
    @evaluate_course = EvaluateCourse.find(params[:id])
    unless current_login.isstaff==true
      @studentid=current_login.student_id
      @programme=Programme.find(:first, :conditions => ['id=?', Student.find(@studentid).course_id]) 
    else
      @lecturer_programme = current_login.staff.position.unit
    end
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_list = Programme.find(:all, :conditions=>['id IN (?)',Array(@programme.id)])
      @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
      @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
      @subjectlist_preselect_prog = Programme.find(@programme.id).descendants.at_depth(2)
      @preselect_prog = @programme.id
    else
      if @lecturer_programme == 'Commonsubject'
      else
        @programme_list = Programme.roots
        @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
        @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
        @subjectlist_preselect_prog = Programme.at_depth(2)
      end
    end
  end

  # POST /evaluate_courses
  # POST /evaluate_courses.xml
  def create
    @evaluate_course = EvaluateCourse.new(params[:evaluate_course])
    unless current_login.isstaff==true
      @studentid=current_login.student_id
      @programme=Programme.find(:first, :conditions => ['id=?', Student.find(@studentid).course_id]) 
    else
      @lecturer_programme = current_login.staff.position.unit
    end
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_list = Programme.find(:all, :conditions=>['id IN (?)',Array(@programme.id)])
      @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
      @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
      @subjectlist_preselect_prog = Programme.find(@programme.id).descendants.at_depth(2)
      @preselect_prog = @programme.id
    else
      if @lecturer_programme == 'Commonsubject'
      else
        @programme_list = Programme.roots
        @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
        @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
        @subjectlist_preselect_prog = Programme.at_depth(2)
      end
    end

    respond_to do |format|
      if @evaluate_course.save
        format.html { redirect_to(@evaluate_course, :notice =>   t('evaluate_course.title2')+" "+t('updated')) }
        format.xml  { render :xml => @evaluate_course, :status => :created, :location => @evaluate_course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evaluate_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evaluate_courses/1
  # PUT /evaluate_courses/1.xml
  def update
    @evaluate_course = EvaluateCourse.find(params[:id])
    unless current_login.isstaff==true
      @studentid=current_login.student_id
      @programme=Programme.find(:first, :conditions => ['id=?', Student.find(@studentid).course_id]) 
    else
      @lecturer_programme = current_login.staff.position.unit
    end
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_list = Programme.find(:all, :conditions=>['id IN (?)',Array(@programme.id)])
      @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
      @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
      @subjectlist_preselect_prog = Programme.find(@programme.id).descendants.at_depth(2)
      @preselect_prog = @programme.id
    else
      if @lecturer_programme == 'Commonsubject'
      else
        @programme_list = Programme.roots
        @staff_id_lecturer = Position.find(:all, :conditions=>['unit IN(?)',@programme_list.map(&:name)]).map(&:staff_id).compact
        @lecturer_list = Staff.find(:all, :conditions=>['id IN(?)',@staff_id_lecturer],:order=>'name ASC')
        @subjectlist_preselect_prog = Programme.at_depth(2)
      end
    end
    respond_to do |format|
      if @evaluate_course.update_attributes(params[:evaluate_course])
        format.html { redirect_to(@evaluate_course, :notice =>  t('evaluate_course.title2')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evaluate_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluate_courses/1
  # DELETE /evaluate_courses/1.xml
  def destroy
    @evaluate_course = EvaluateCourse.find(params[:id])
    @evaluate_course.destroy

    respond_to do |format|
      format.html { redirect_to(evaluate_courses_url) }
      format.xml  { head :ok }
    end
  end
  
  def courseevaluation
     @evaluate_course = EvaluateCourse.find(params[:id])
     render :layout => 'report'
  end
end
