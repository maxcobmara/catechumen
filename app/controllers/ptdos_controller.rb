class PtdosController < ApplicationController
  # GET /ptdos
  # GET /ptdos.xml
  def index
    @ptdos = Ptdo.with_permissions_to(:index).search(params[:search]).paginate(:per_page => 20, :page => params[:page]) 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptdos }
    end
  end

  # GET /ptdos/1
  # GET /ptdos/1.xml
  def show
    @ptdo = Ptdo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptdo }
    end
  end

  # GET /ptdos/new
  # GET /ptdos/new.xml
  def new
    @ptdo = Ptdo.new(:ptschedule_id => params[:ptschedule_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ptdo }
    end
  end

  # GET /ptdos/1/edit
  def edit
    @ptdo = Ptdo.find(params[:id])
  end

  # POST /ptdos
  # POST /ptdos.xml
  def create
    @ptdo = Ptdo.new(params[:ptdo])

    respond_to do |format|
      if @ptdo.save
        flash[:notice] = t('ptdos.title')+" "+t('created')
        format.html { redirect_to(@ptdo) }
        format.xml  { render :xml => @ptdo, :status => :created, :location => @ptdo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ptdo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ptdos/1
  # PUT /ptdos/1.xml
  def update
    @ptdo = Ptdo.find(params[:id])

    respond_to do |format|
      if @ptdo.update_attributes(params[:ptdo])
        flash[:notice] =  t('ptdos.title')+" "+t('updated')
        format.html { redirect_to(@ptdo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ptdo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptdos/1
  # DELETE /ptdos/1.xml
  def destroy
    @ptdo = Ptdo.find(params[:id])
    @ptdo.destroy

    respond_to do |format|
      format.html { redirect_to(ptdos_url) }
      format.xml  { head :ok }
    end
  end
  
  def show_total_days
    #restrict attendance by trainee_report (NOT NULL) whereby..
    #training really happen when : (1) schedule start (date) >= Date.today, (2) schedule budget must be approved (3) must meet minimum participant
    currentyear_schedule = Ptschedule.find(:all, :conditions =>['start >=? and start <=?', Date.today.beginning_of_year, Date.today.end_of_year]).map(&:id)
    @ptdos = Ptdo.find(:all, :conditions => ['final_approve=? and staff_id=? and trainee_report is not null and ptschedule_id IN(?)', true, params[:id], currentyear_schedule]) 
    #to retrieve --> http://localhost:3000/ptdos/show_total_days/1.....http://localhost:3000/ptdos/show_total_days/3.....1,3 --> staff_id!
   
   respond_to do |format|
      format.html # show_total_days.html.erb
      format.xml  { render :xml => @ptdos }
    end
  end
  
  def organized_course_manager
    @filters=Ptdo.filters
    if params[:show] && params[:show]!="all2" #&& @filters.collect{|f| f[:scope]}.include?(params[:show])
      startbegindate=Date.new(params[:show].to_i,1,1)
      startenddate=Date.new(params[:show].to_i,12,31)
      unless params[:search].nil?
        searched_course_ids=Ptcourse.find(:all, :conditions => ['name ILIKE(?)', "%#{params[:search]}%"]).map(&:id)
        approved_budget_sch_ids= Ptschedule.find(:all, :conditions => ['budget_ok=? and start>=? and start<=? and ptcourse_id IN(?)', true, startbegindate, startenddate, searched_course_ids]).map(&:id)
        @ptdos = Ptdo.find(:all, :conditions => ['final_approve=? and ptschedule_id IN(?)', true, approved_budget_sch_ids], :order => "ptschedule_id DESC")
      else
        approved_budget_sch_ids= Ptschedule.find(:all, :conditions => ['budget_ok=? and start>=? and start<=?', true, startbegindate, startenddate]).map(&:id)
        @ptdos = Ptdo.find(:all, :conditions => ['final_approve=? and ptschedule_id IN(?)', true, approved_budget_sch_ids], :order => "ptschedule_id DESC")
      end
    else
      unless params[:search].nil?
        searched_course_ids=Ptcourse.find(:all, :conditions => ['name ILIKE(?)', "%#{params[:search]}%"]).map(&:id)
        @ptdos=Ptdo.find(:all, :conditions => ['id IN(?) and ptcourse_id IN(?)',Ptdo.all2.map(&:id), searched_course_ids], :order => "ptschedule_id DESC")
      else
        @ptdos=Ptdo.send("all2")
        #@ptdos = Ptdo.all2
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptschedules }
    end
  end
  
end
