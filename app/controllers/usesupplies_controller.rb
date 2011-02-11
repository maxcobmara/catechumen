class UsesuppliesController < ApplicationController
  # GET /usesupplies
  # GET /usesupplies.xml
  def index
    @usesupplies = Usesupply.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usesupplies }
    end
  end

  # GET /usesupplies/1
  # GET /usesupplies/1.xml
  def show
    @usesupply = Usesupply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usesupply }
    end
  end

  # GET /usesupplies/new
  # GET /usesupplies/new.xml
  def new
    @usesupply = Usesupply.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usesupply }
    end
  end

  # GET /usesupplies/1/edit
  def edit
    @usesupply = Usesupply.find(params[:id])
  end

  # POST /usesupplies
  # POST /usesupplies.xml
  def create
    @usesupply = Usesupply.new(params[:usesupply])

    respond_to do |format|
      if @usesupply.save
        flash[:notice] = 'Usesupply was successfully created.'
        format.html { redirect_to(@usesupply) }
        format.xml  { render :xml => @usesupply, :status => :created, :location => @usesupply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usesupply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usesupplies/1
  # PUT /usesupplies/1.xml
  def update
    @usesupply = Usesupply.find(params[:id])

    respond_to do |format|
      if @usesupply.update_attributes(params[:usesupply])
        flash[:notice] = 'Usesupply was successfully updated.'
        format.html { redirect_to(@usesupply) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usesupply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usesupplies/1
  # DELETE /usesupplies/1.xml
  def destroy
    @usesupply = Usesupply.find(params[:id])
    @usesupply.destroy

    respond_to do |format|
      format.html { redirect_to(usesupplies_url) }
      format.xml  { head :ok }
    end
  end
end
