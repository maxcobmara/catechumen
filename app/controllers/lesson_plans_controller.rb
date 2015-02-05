class LessonPlansController < ApplicationController
  # GET /lesson_plans
  # GET /lesson_plans.xml
  def index
    @position_exist = Login.current_login.staff.position
    if @position_exist 
      @lesson_plans = LessonPlan.all
    end
    respond_to do |format|
      if @position_exist
        format.html # index.html.erb
        format.xml  { render :xml => @lesson_plans }
      else
        format.html { redirect_to "/home", :notice =>t('position_required')+t('lesson_plan.title')}
        format.xml
      end
    end
  end

  # GET /lesson_plans/1
  # GET /lesson_plans/1.xml
  def show
    @lesson_plan = LessonPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lesson_plan }
    end
  end

  # GET /lesson_plans/new
  # GET /lesson_plans/new.xml
  def new
    @lesson_plan = LessonPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lesson_plan }
    end
  end

  # GET /lesson_plans/1/edit
  def edit
    @lesson_plan = LessonPlan.find(params[:id])
    #admin
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
    @is_admin=true if current_roles.include?("Administration")
  end

  # POST /lesson_plans
  # POST /lesson_plans.xml
  def create
    @lesson_plan = LessonPlan.new(params[:lesson_plan])

    respond_to do |format|
      if @lesson_plan.save
        format.html { redirect_to(@lesson_plan, :notice => 'LessonPlan was successfully created.') }
        format.xml  { render :xml => @lesson_plan, :status => :created, :location => @lesson_plan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lesson_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lesson_plans/1
  # PUT /lesson_plans/1.xml
  def update
    @lesson_plan = LessonPlan.find(params[:id])
    newlocation = params[:new_location]
    if newlocation!=nil
      scheduleid = params[:lesson_plan][:schedule]
      scheduleid = @lesson_plan.schedule if scheduleid==nil
      if scheduleid!=nil
        schedule = WeeklytimetableDetail.find(scheduleid) 
        schedule.location_desc = newlocation
        schedule.save!
      end
    end

    respond_to do |format|
      if @lesson_plan.update_attributes(params[:lesson_plan])
        format.html { redirect_to(@lesson_plan, :notice => t('lesson_plan.title')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lesson_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_plans/1
  # DELETE /lesson_plans/1.xml
  def destroy
    @lesson_plan = LessonPlan.find(params[:id])
    @lesson_plan.destroy

    respond_to do |format|
      format.html { redirect_to(lesson_plans_url) }
      format.xml  { head :ok }
    end
  end
  
  def lesson_plan
      @lesson_plan = LessonPlan.find(params[:id])
      render :layout => 'report'
  end
  
  def lessonplan_reporting
    @lesson_plan = LessonPlan.find(params[:id])  
    #admin
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:name)
    @is_admin=true if current_roles.include?("Administration")
  end
  def index_report
    @position_exist = Login.current_login.staff.position
    if @position_exist 
      @lesson_plans = LessonPlan.find(:all, :conditions=> ['hod_approved=?', true])
    else
       redirect_to "/home", :notice =>t('position_required')+t('lesson_plan.title')
    end
  end
  def lesson_plan_report
      @lesson_plan = LessonPlan.find(params[:id])
      render :layout => 'report'
  end
  
end
