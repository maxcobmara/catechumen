class StaffclassificationsController < ApplicationController
  # GET /staffclassifications
  # GET /staffclassifications.xml
  def index
    @staffclassifications = Staffclassification.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffclassifications }
    end
  end

  # GET /staffclassifications/1
  # GET /staffclassifications/1.xml
  def show
    @staffclassification = Staffclassification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffclassification }
    end
  end

  # GET /staffclassifications/new
  # GET /staffclassifications/new.xml
  def new
    @staffclassification = Staffclassification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffclassification }
    end
  end

  # GET /staffclassifications/1/edit
  def edit
    @staffclassification = Staffclassification.find(params[:id])
  end

  # POST /staffclassifications
  # POST /staffclassifications.xml
  def create
    @staffclassification = Staffclassification.new(params[:staffclassification])

    respond_to do |format|
      if @staffclassification.save
        flash[:notice] = 'Staffclassification was successfully created.'
        format.html { redirect_to(@staffclassification) }
        format.xml  { render :xml => @staffclassification, :status => :created, :location => @staffclassification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staffclassification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffclassifications/1
  # PUT /staffclassifications/1.xml
  def update
    @staffclassification = Staffclassification.find(params[:id])

    respond_to do |format|
      if @staffclassification.update_attributes(params[:staffclassification])
        flash[:notice] = 'Staffclassification was successfully updated.'
        format.html { redirect_to(@staffclassification) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staffclassification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffclassifications/1
  # DELETE /staffclassifications/1.xml
  def destroy
    @staffclassification = Staffclassification.find(params[:id])
    @staffclassification.destroy

    respond_to do |format|
      format.html { redirect_to(staffclassifications_url) }
      format.xml  { head :ok }
    end
  end
end
