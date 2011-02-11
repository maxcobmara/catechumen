class EvactivitiesController < ApplicationController
  # GET /evactivities
  # GET /evactivities.xml
  def index
    @evactivities = Evactivity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @evactivities }
    end
  end

  # GET /evactivities/1
  # GET /evactivities/1.xml
  def show
    @evactivity = Evactivity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evactivity }
    end
  end

  # GET /evactivities/new
  # GET /evactivities/new.xml
  def new
    @evactivity = Evactivity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evactivity }
    end
  end

  # GET /evactivities/1/edit
  def edit
    @evactivity = Evactivity.find(params[:id])
  end

  # POST /evactivities
  # POST /evactivities.xml
  def create
    @evactivity = Evactivity.new(params[:evactivity])

    respond_to do |format|
      if @evactivity.save
        flash[:notice] = 'Evactivity was successfully created.'
        format.html { redirect_to(@evactivity) }
        format.xml  { render :xml => @evactivity, :status => :created, :location => @evactivity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evactivity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evactivities/1
  # PUT /evactivities/1.xml
  def update
    @evactivity = Evactivity.find(params[:id])

    respond_to do |format|
      if @evactivity.update_attributes(params[:evactivity])
        flash[:notice] = 'Evactivity was successfully updated.'
        format.html { redirect_to(@evactivity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evactivity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evactivities/1
  # DELETE /evactivities/1.xml
  def destroy
    @evactivity = Evactivity.find(params[:id])
    @evactivity.destroy

    respond_to do |format|
      format.html { redirect_to(evactivities_url) }
      format.xml  { head :ok }
    end
  end
end
