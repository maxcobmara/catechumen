class BooleanchoicesController < ApplicationController
  # GET /booleanchoices
  # GET /booleanchoices.xml
  def index
    @booleanchoices = Booleanchoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @booleanchoices }
    end
  end

  # GET /booleanchoices/1
  # GET /booleanchoices/1.xml
  def show
    @booleanchoice = Booleanchoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booleanchoice }
    end
  end

  # GET /booleanchoices/new
  # GET /booleanchoices/new.xml
  def new
    @booleanchoice = Booleanchoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booleanchoice }
    end
  end

  # GET /booleanchoices/1/edit
  def edit
    @booleanchoice = Booleanchoice.find(params[:id])
  end

  # POST /booleanchoices
  # POST /booleanchoices.xml
  def create
    @booleanchoice = Booleanchoice.new(params[:booleanchoice])

    respond_to do |format|
      if @booleanchoice.save
        format.html { redirect_to(@booleanchoice, :notice => 'Booleanchoice was successfully created.') }
        format.xml  { render :xml => @booleanchoice, :status => :created, :location => @booleanchoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @booleanchoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /booleanchoices/1
  # PUT /booleanchoices/1.xml
  def update
    @booleanchoice = Booleanchoice.find(params[:id])

    respond_to do |format|
      if @booleanchoice.update_attributes(params[:booleanchoice])
        format.html { redirect_to(@booleanchoice, :notice => 'Booleanchoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @booleanchoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /booleanchoices/1
  # DELETE /booleanchoices/1.xml
  def destroy
    @booleanchoice = Booleanchoice.find(params[:id])
    @booleanchoice.destroy

    respond_to do |format|
      format.html { redirect_to(booleanchoices_url) }
      format.xml  { head :ok }
    end
  end
end
