class ResidencesController < ApplicationController
  # GET /residences
  # GET /residences.xml
  def index
    @residences = Residence.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @residences }
    end
  end

  # GET /residences/1
  # GET /residences/1.xml
  def show
    @residence = Residence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @residence }
    end
  end

  # GET /residences/new
  # GET /residences/new.xml
  def new
    @residence = Residence.new(:parent_id => params[:parent_id])
    @residence.assets.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @residence }
    end
  end

  # GET /residences/1/edit
  def edit
    @residence = Residence.find(params[:id])
  end
  
  def addasset
    @residence = Residence.find(params[:id])
    
  end

  # POST /residences
  # POST /residences.xml
  def create
    @residence = Residence.new(params[:residence])

    respond_to do |format|
      if @residence.save
        flash[:notice] = 'Residence was successfully created.'
        format.html { redirect_to(@residence) }
        format.xml  { render :xml => @residence, :status => :created, :location => @residence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @residence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /residences/1
  # PUT /residences/1.xml
  def update
    @residence = Residence.find(params[:id])

    respond_to do |format|
      if @residence.update_attributes(params[:residence])
        flash[:notice] = 'Residence was successfully updated.'
        format.html { redirect_to(@residence) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @residence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /residences/1
  # DELETE /residences/1.xml
  def destroy
    @residence = Residence.find(params[:id])
    @residence.destroy

    respond_to do |format|
      format.html { redirect_to(residences_url) }
      format.xml  { head :ok }
    end
  end
end
