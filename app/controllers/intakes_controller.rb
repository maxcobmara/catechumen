class IntakesController < ApplicationController
  # GET /intakes
  # GET /intakes.xml
  def index
    @intakes = Intake.find(:all, :order => "year DESC, intake_no DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @intakes }
    end
  end

  # GET /intakes/1
  # GET /intakes/1.xml
  def show
    @intake = Intake.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @intake }
    end
  end

  # GET /intakes/new
  # GET /intakes/new.xml
  def new
    @intake = Intake.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @intake }
    end
  end

  # GET /intakes/1/edit
  def edit
    @intake = Intake.find(params[:id])
  end

  # POST /intakes
  # POST /intakes.xml
  def create
    @intake = Intake.new(params[:intake])

    respond_to do |format|
      if @intake.save
        flash[:notice] = 'Intake was successfully created.'
        format.html { redirect_to(@intake) }
        format.xml  { render :xml => @intake, :status => :created, :location => @intake }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @intake.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /intakes/1
  # PUT /intakes/1.xml
  def update
    @intake = Intake.find(params[:id])

    respond_to do |format|
      if @intake.update_attributes(params[:intake])
        flash[:notice] = 'Intake was successfully updated.'
        format.html { redirect_to(@intake) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @intake.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /intakes/1
  # DELETE /intakes/1.xml
  def destroy
    @intake = Intake.find(params[:id])
    @intake.destroy

    respond_to do |format|
      format.html { redirect_to(intakes_url) }
      format.xml  { head :ok }
    end
  end
end
