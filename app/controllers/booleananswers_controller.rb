class BooleananswersController < ApplicationController
  # GET /booleananswers
  # GET /booleananswers.xml
  def index
    @booleananswers = Booleananswer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @booleananswers }
    end
  end

  # GET /booleananswers/1
  # GET /booleananswers/1.xml
  def show
    @booleananswer = Booleananswer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booleananswer }
    end
  end

  # GET /booleananswers/new
  # GET /booleananswers/new.xml
  def new
    @booleananswer = Booleananswer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booleananswer }
    end
  end

  # GET /booleananswers/1/edit
  def edit
    @booleananswer = Booleananswer.find(params[:id])
  end

  # POST /booleananswers
  # POST /booleananswers.xml
  def create
    @booleananswer = Booleananswer.new(params[:booleananswer])

    respond_to do |format|
      if @booleananswer.save
        format.html { redirect_to(@booleananswer, :notice => 'Booleananswer was successfully created.') }
        format.xml  { render :xml => @booleananswer, :status => :created, :location => @booleananswer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @booleananswer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /booleananswers/1
  # PUT /booleananswers/1.xml
  def update
    @booleananswer = Booleananswer.find(params[:id])

    respond_to do |format|
      if @booleananswer.update_attributes(params[:booleananswer])
        format.html { redirect_to(@booleananswer, :notice => 'Booleananswer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @booleananswer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /booleananswers/1
  # DELETE /booleananswers/1.xml
  def destroy
    @booleananswer = Booleananswer.find(params[:id])
    @booleananswer.destroy

    respond_to do |format|
      format.html { redirect_to(booleananswers_url) }
      format.xml  { head :ok }
    end
  end
end
