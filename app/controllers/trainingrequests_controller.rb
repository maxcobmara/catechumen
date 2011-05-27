class TrainingrequestsController < ApplicationController
  # GET /trainingrequests
  # GET /trainingrequests.xml
  def index
    @trainingrequests = Trainingrequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trainingrequests }
    end
  end

  # GET /trainingrequests/1
  # GET /trainingrequests/1.xml
  def show
    @trainingrequest = Trainingrequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trainingrequest }
    end
  end

  # GET /trainingrequests/new
  # GET /trainingrequests/new.xml
  def new
    @trainingrequest = Trainingrequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trainingrequest }
    end
  end

  # GET /trainingrequests/1/edit
  def edit
    @trainingrequest = Trainingrequest.find(params[:id])
  end

  # POST /trainingrequests
  # POST /trainingrequests.xml
  def create
    @trainingrequest = Trainingrequest.new(params[:trainingrequest])

    respond_to do |format|
      if @trainingrequest.save
        flash[:notice] = 'Trainingrequest was successfully created.'
        format.html { redirect_to(@trainingrequest) }
        format.xml  { render :xml => @trainingrequest, :status => :created, :location => @trainingrequest }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trainingrequest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trainingrequests/1
  # PUT /trainingrequests/1.xml
  def update
    @trainingrequest = Trainingrequest.find(params[:id])

    respond_to do |format|
      if @trainingrequest.update_attributes(params[:trainingrequest])
        flash[:notice] = 'Trainingrequest was successfully updated.'
        format.html { redirect_to(@trainingrequest) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trainingrequest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trainingrequests/1
  # DELETE /trainingrequests/1.xml
  def destroy
    @trainingrequest = Trainingrequest.find(params[:id])
    @trainingrequest.destroy

    respond_to do |format|
      format.html { redirect_to(trainingrequests_url) }
      format.xml  { head :ok }
    end
  end
end
