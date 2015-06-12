class PtdosController < ApplicationController
  # GET /ptdos
  # GET /ptdos.xml
  def index
    @position_exist = current_login.staff.position
    if @position_exist && @position_exist.unit
      #@ptdos = Ptdo.with_permissions_to(:index).search(params[:search]).paginate(:per_page => 20, :page => params[:page]) 
      ###
      all2a=Ptdo.with_permissions_to(:index)
      @filters=Ptdo.filters(all2a)
      if params[:show] && params[:search]
        @ptdos = Ptdo.with_permissions_to(:index).search(params[:show], params[:search])
      else
        @ptdos = Ptdo.with_permissions_to(:index).find(:all, :order => 'ptschedule_id DESC')
      end
      @ptdos = @ptdos.paginate(:per_page => 20, :page => params[:page]) 
      ###
    end
    respond_to do |format|
      if @position_exist && @position_exist.unit
        format.html # index.html.erb
        format.xml  { render :xml => @ptdos}
      else
        format.html {redirect_to "/home", :notice =>t('position_required')+t('ptdos.title')}
        format.xml  { render :xml => @ptdos.errors, :status => :unprocessable_entity }
      end
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
        flash[:notice] =  t('ptdos.title2')+" "+t('updated')
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
  
end
