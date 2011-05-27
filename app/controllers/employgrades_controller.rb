class EmploygradesController < ApplicationController
  # GET /employgrades
  # GET /employgrades.xml
  def index
    @employgrades = Employgrade.find(:all, :order => 'name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employgrades }
    end
  end

  # GET /employgrades/1
  # GET /employgrades/1.xml
  def show
    @employgrade = Employgrade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employgrade }
    end
  end

  # GET /employgrades/new
  # GET /employgrades/new.xml
  def new
    @employgrade = Employgrade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employgrade }
    end
  end

  # GET /employgrades/1/edit
  def edit
    @employgrade = Employgrade.find(params[:id])
  end

  # POST /employgrades
  # POST /employgrades.xml
  def create
    @employgrade = Employgrade.new(params[:employgrade])

    respond_to do |format|
      if @employgrade.save
        flash[:notice] = 'Employgrade was successfully created.'
        format.html { redirect_to(@employgrade) }
        format.xml  { render :xml => @employgrade, :status => :created, :location => @employgrade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employgrade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employgrades/1
  # PUT /employgrades/1.xml
  def update
    @employgrade = Employgrade.find(params[:id])

    respond_to do |format|
      if @employgrade.update_attributes(params[:employgrade])
        flash[:notice] = 'Employgrade was successfully updated.'
        format.html { redirect_to(@employgrade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employgrade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employgrades/1
  # DELETE /employgrades/1.xml
  def destroy
    @employgrade = Employgrade.find(params[:id])
    @employgrade.destroy

    respond_to do |format|
      format.html { redirect_to(employgrades_url) }
      format.xml  { head :ok }
    end
  end
end
