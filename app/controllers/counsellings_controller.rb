class CounsellingsController < ApplicationController
  # GET /counsellings
  # GET /counsellings.xml
  def index
    @counsellings = Counselling.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @counsellings }
    end
  end

  # GET /counsellings/1
  # GET /counsellings/1.xml
  def show
    @counselling = Counselling.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @counselling }
    end
  end

  # GET /counsellings/new
  # GET /counsellings/new.xml
  def new
    @counselling = Counselling.new
    @counselling.scsessions.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @counselling }
    end
  end

  # GET /counsellings/1/edit
  def edit
    @counselling = Counselling.find(params[:id])
  end

  # POST /counsellings
  # POST /counsellings.xml
  def create
    @counselling = Counselling.new(params[:counselling])

    respond_to do |format|
      if @counselling.save
        flash[:notice] = 'Counselling was successfully created.'
        format.html { redirect_to(@counselling) }
        format.xml  { render :xml => @counselling, :status => :created, :location => @counselling }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @counselling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /counsellings/1
  # PUT /counsellings/1.xml
  def update
    @counselling = Counselling.find(params[:id])

    respond_to do |format|
      if @counselling.update_attributes(params[:counselling])
        flash[:notice] = 'Counselling was successfully updated.'
        format.html { redirect_to(@counselling) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @counselling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /counsellings/1
  # DELETE /counsellings/1.xml
  def destroy
    @counselling = Counselling.find(params[:id])
    @counselling.destroy

    respond_to do |format|
      format.html { redirect_to(counsellings_url) }
      format.xml  { head :ok }
    end
  end
end
