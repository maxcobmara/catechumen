class PtschedulesController < ApplicationController
  filter_access_to :all
  # GET /ptschedules
  # GET /ptschedules.xml
  def index
    @ptschedules = Ptschedule.search(params[:search])  

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptschedules }
    end
  end

  # GET /ptschedules/1
  # GET /ptschedules/1.xml
  def show
    @ptschedule = Ptschedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptschedule }
    end
  end

  # GET /ptschedules/new
  # GET /ptschedules/new.xml
  def new
    @ptschedule = Ptschedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ptschedule }
    end
  end

  # GET /ptschedules/1/edit
  def edit
    @ptschedule = Ptschedule.find(params[:id])
  end

  # POST /ptschedules
  # POST /ptschedules.xml
  def create
    @ptschedule = Ptschedule.new(params[:ptschedule])

    respond_to do |format|
      if @ptschedule.save
        flash[:notice] = t('ptschedule.title')+" "+t('created')
        format.html { redirect_to(@ptschedule) }
        format.xml  { render :xml => @ptschedule, :status => :created, :location => @ptschedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ptschedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ptschedules/1
  # PUT /ptschedules/1.xml
  def update
    @ptschedule = Ptschedule.find(params[:id])

    respond_to do |format|
      if @ptschedule.update_attributes(params[:ptschedule])
        flash[:notice] =  t('ptschedule.title')+" "+t('updated')
        format.html { redirect_to(@ptschedule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ptschedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptschedules/1
  # DELETE /ptschedules/1.xml
  def destroy
    @ptschedule = Ptschedule.find(params[:id])
    @ptschedule.destroy

    respond_to do |format|
      format.html { redirect_to(ptschedules_url) }
      format.xml  { head :ok }
    end
  end
  
  def apply
    @ptschedules = Ptschedule.find(:all, :order => "start ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptschedules }
    end
  end
  
  ###removed from ptdo - 26May2015
  def organized_course_manager
    @filters=Ptschedule.filters
    if params[:show] && params[:show]!="all2" 
      startbegindate=Date.new(params[:show].to_i,1,1)
      startenddate=Date.new(params[:show].to_i,12,31)
      unless params[:search].nil?
        @ptschedules=Ptschedule.find(:all, :conditions => ['budget_ok=? and start>=? and start<=? and ptcourse_id IN(?)', true, startbegindate, startenddate, searched_course_ids], :order => 'start DESC')
      else
        @ptschedules=Ptschedule.find(:all, :conditions => ['budget_ok=? and start>=? and start<=?', true, startbegindate, startenddate], :order => 'start DESC')
      end
    else
      unless params[:search].nil?
        searched_course_ids=Ptcourse.find(:all, :conditions => ['name ILIKE(?)', "%#{params[:search]}%"]).map(&:id)
        @ptschedules=Ptschedule.find(:all, :conditions => ['ptcourse_id IN(?)', searched_course_ids], :order => 'start DESC')
      else
        @ptschedules=Ptschedule.send("all2")
      end
    end
    @ptschedules = @ptschedules.paginate(:per_page => 5, :page => params[:page]) 
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @ptschedules }
    end
  end
  
end
