class TrainingreportsController < ApplicationController
  # GET /trainingreports
  # GET /trainingreports.xml
  def index
    @trainingreports = Trainingreport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trainingreports }
    end
  end

  # GET /trainingreports/1
  # GET /trainingreports/1.xml
  def show
    @trainingreport = Trainingreport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trainingreport }
    end
  end

  # GET /trainingreports/new
  # GET /trainingreports/new.xml
  def new
    @trainingreport = Trainingreport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trainingreport }
    end
  end

  # GET /trainingreports/1/edit
  def edit
    @trainingreport = Trainingreport.find(params[:id])
  end

  # POST /trainingreports
  # POST /trainingreports.xml
  def create
    @trainingreport = Trainingreport.new(params[:trainingreport])

    respond_to do |format|
      if @trainingreport.save
        flash[:notice] = 'Trainingreport was successfully created.'
        format.html { redirect_to(@trainingreport) }
        format.xml  { render :xml => @trainingreport, :status => :created, :location => @trainingreport }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trainingreport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trainingreports/1
  # PUT /trainingreports/1.xml
  def update
    @trainingreport = Trainingreport.find(params[:id])

    respond_to do |format|
      if @trainingreport.update_attributes(params[:trainingreport])
        flash[:notice] = 'Trainingreport was successfully updated.'
        format.html { redirect_to(@trainingreport) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trainingreport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trainingreports/1
  # DELETE /trainingreports/1.xml
  def destroy
    @trainingreport = Trainingreport.find(params[:id])
    @trainingreport.destroy

    respond_to do |format|
      format.html { redirect_to(trainingreports_url) }
      format.xml  { head :ok }
    end
  end
end
