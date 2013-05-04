class OfficecarsController < ApplicationController
  # GET /officecars
  # GET /officecars.xml
  def index
    @officecars = Officecar.find(:all, :order => "id")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @officecars }
    end
  end

  # GET /officecars/1
  # GET /officecars/1.xml
  def show
    @officecar = Officecar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @officecar }
    end
  end

  # GET /officecars/new
  # GET /officecars/new.xml
  def new
    @officecar = Officecar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @officecar }
    end
  end

  # GET /officecars/1/edit
  def edit
    @officecar = Officecar.find(params[:id])
  end

  # POST /officecars
  # POST /officecars.xml
  def create
    @officecar = Officecar.new(params[:officecar])

    respond_to do |format|
      if @officecar.save
        flash[:notice] = 'Officecar was successfully created.'
        format.html { redirect_to(@officecar) }
        format.xml  { render :xml => @officecar, :status => :created, :location => @officecar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @officecar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /officecars/1
  # PUT /officecars/1.xml
  def update
    @officecar = Officecar.find(params[:id])

    respond_to do |format|
      if @officecar.update_attributes(params[:officecar])
        flash[:notice] = 'Officecar was successfully updated.'
        format.html { redirect_to(@officecar) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @officecar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /officecars/1
  # DELETE /officecars/1.xml
  def destroy
    @officecar = Officecar.find(params[:id])
    @officecar.destroy

    respond_to do |format|
      format.html { redirect_to(officecars_url) }
      format.xml  { head :ok }
    end
  end
end
