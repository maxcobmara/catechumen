class TrainneedsController < ApplicationController
  # GET /trainneeds
  # GET /trainneeds.xml
  def index
    @trainneeds = Trainneed.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trainneeds }
    end
  end

  # GET /trainneeds/1
  # GET /trainneeds/1.xml
  def show
    @trainneed = Trainneed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trainneed }
    end
  end

  # GET /trainneeds/new
  # GET /trainneeds/new.xml
  def new
    @trainneed = Trainneed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trainneed }
    end
  end

  # GET /trainneeds/1/edit
  def edit
    @trainneed = Trainneed.find(params[:id])
  end

  # POST /trainneeds
  # POST /trainneeds.xml
  def create
    @trainneed = Trainneed.new(params[:trainneed])

    respond_to do |format|
      if @trainneed.save
        flash[:notice] = 'Trainneed was successfully created.'
        format.html { redirect_to(@trainneed) }
        format.xml  { render :xml => @trainneed, :status => :created, :location => @trainneed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trainneed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trainneeds/1
  # PUT /trainneeds/1.xml
  def update
    @trainneed = Trainneed.find(params[:id])

    respond_to do |format|
      if @trainneed.update_attributes(params[:trainneed])
        flash[:notice] = 'Trainneed was successfully updated.'
        format.html { redirect_to(@trainneed) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trainneed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trainneeds/1
  # DELETE /trainneeds/1.xml
  def destroy
    @trainneed = Trainneed.find(params[:id])
    @trainneed.destroy

    respond_to do |format|
      format.html { redirect_to(trainneeds_url) }
      format.xml  { head :ok }
    end
  end
end
