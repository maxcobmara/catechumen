class PtbudgetsController < ApplicationController
  filter_resource_access
  # GET /ptbudgets
  # GET /ptbudgets.xml
  def index
    @filters=Ptbudget.filters
    if params[:show] && params[:show]!="all2" #&& @filters.collect{|f| f[:scope]}.include?(params[:show])
      budgetstart=Ptbudget.all[0].budget_start
      begindate=Date.new(params[:show].to_i, budgetstart.month, budgetstart.day)
      enddate=begindate+1.year-1.day
      @ptbudgets = Ptbudget.find(:all, :conditions => ['fiscalstart >=? and fiscalstart <?', begindate, enddate])
    else
      @ptbudgets = Ptbudget.find(:all, :order => 'fiscalstart DESC')
    end 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptbudgets }
    end
  end

  # GET /ptbudgets/1
  # GET /ptbudgets/1.xml
  def show
    @ptbudget = Ptbudget.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptbudget }
    end
  end

  # GET /ptbudgets/new
  # GET /ptbudgets/new.xml
  def new
    @newtype = params[:newtype]
    @ptbudget = Ptbudget.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ptbudget }
    end
  end

  # GET /ptbudgets/1/edit
  def edit
    @ptbudget = Ptbudget.find(params[:id])
  end

  # POST /ptbudgets
  # POST /ptbudgets.xml
  def create
    @newtype = params[:newtype]
    @ptbudget = Ptbudget.new(params[:ptbudget])
    if @newtype.nil?
      ab=@ptbudget.fiscalstart
      if ab.month==@ptbudget.budget_start.month && ab.day==@ptbudget.budget_start.day
        @newtype="1"
      else
        @newtype="2"
      end
    end
    respond_to do |format|
      if @ptbudget.save
        flash[:notice] =  t('ptbudget.new')+" "+t('created')
        format.html { redirect_to(@ptbudget) }
        format.xml  { render :xml => @ptbudget, :status => :created, :location => @ptbudget }
      else
        flash[:notice]=t('ptbudget.budget_start_compulsory')
	format.html { redirect_to new_ptbudget_path(@ptbudget,  :newtype => @newtype) }
        format.xml  { render :xml => @ptbudget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ptbudgets/1
  # PUT /ptbudgets/1.xml
  def update
    @ptbudget = Ptbudget.find(params[:id])

    respond_to do |format|
      if @ptbudget.update_attributes(params[:ptbudget])
        flash[:notice] =  t('ptbudget.title')+" "+t('updated')
        format.html { redirect_to(@ptbudget) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ptbudget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptbudgets/1
  # DELETE /ptbudgets/1.xml
  def destroy
    @ptbudget = Ptbudget.find(params[:id])
    @ptbudget.destroy

    respond_to do |format|
      format.html { redirect_to(ptbudgets_url) }
      format.xml  { head :ok }
    end
  end
end
