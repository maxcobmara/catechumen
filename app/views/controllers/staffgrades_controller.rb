class StaffgradesController < ApplicationController
  # GET /staffgrades
  # GET /staffgrades.xml
  def index
    @staffgrades = Staffgrade.all
    @staffgrades_gelas = @staffgrades.group_by { |t| t.gelas_name }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffgrades }
    end
  end

  # GET /staffgrades/1
  # GET /staffgrades/1.xml
  def show
    @staffgrade = Staffgrade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffgrade }
    end
  end

  # GET /staffgrades/new
  # GET /staffgrades/new.xml
  def new
    @staffgrade = Staffgrade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffgrade }
    end
  end

  # GET /staffgrades/1/edit
  def edit
    @staffgrade = Staffgrade.find(params[:id])
  end

  # POST /staffgrades
  # POST /staffgrades.xml
  def create
    @staffgrade = Staffgrade.new(params[:staffgrade])

    respond_to do |format|
      if @staffgrade.save
        flash[:notice] = 'Staffgrade was successfully created.'
        format.html { redirect_to(@staffgrade) }
        format.xml  { render :xml => @staffgrade, :status => :created, :location => @staffgrade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staffgrade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffgrades/1
  # PUT /staffgrades/1.xml
  def update
    @staffgrade = Staffgrade.find(params[:id])

    respond_to do |format|
      if @staffgrade.update_attributes(params[:staffgrade])
        flash[:notice] = 'Staffgrade was successfully updated.'
        format.html { redirect_to(@staffgrade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staffgrade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffgrades/1
  # DELETE /staffgrades/1.xml
  def destroy
    @staffgrade = Staffgrade.find(params[:id])
    @staffgrade.destroy

    respond_to do |format|
      format.html { redirect_to(staffgrades_url) }
      format.xml  { head :ok }
    end
  end
end
