class AnswerchoicesController < ApplicationController
  # GET /answerchoices
  # GET /answerchoices.xml
  def index
    @answerchoices = Answerchoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answerchoices }
    end
  end

  # GET /answerchoices/1
  # GET /answerchoices/1.xml
  def show
    @answerchoice = Answerchoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answerchoice }
    end
  end

  # GET /answerchoices/new
  # GET /answerchoices/new.xml
  def new
    @answerchoice = Answerchoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answerchoice }
    end
  end

  # GET /answerchoices/1/edit
  def edit
    @answerchoice = Answerchoice.find(params[:id])
  end

  # POST /answerchoices
  # POST /answerchoices.xml
  def create
    @answerchoice = Answerchoice.new(params[:answerchoice])

    respond_to do |format|
      if @answerchoice.save
        format.html { redirect_to(@answerchoice, :notice => 'Answerchoice was successfully created.') }
        format.xml  { render :xml => @answerchoice, :status => :created, :location => @answerchoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answerchoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /answerchoices/1
  # PUT /answerchoices/1.xml
  def update
    @answerchoice = Answerchoice.find(params[:id])

    respond_to do |format|
      if @answerchoice.update_attributes(params[:answerchoice])
        format.html { redirect_to(@answerchoice, :notice => 'Answerchoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answerchoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answerchoices/1
  # DELETE /answerchoices/1.xml
  def destroy
    @answerchoice = Answerchoice.find(params[:id])
    @answerchoice.destroy

    respond_to do |format|
      format.html { redirect_to(answerchoices_url) }
      format.xml  { head :ok }
    end
  end
end
