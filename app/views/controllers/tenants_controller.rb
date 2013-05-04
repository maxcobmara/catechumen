class TenantsController < ApplicationController
  # GET /tenants
  # GET /tenants.xml
  def index
    @tenants = Tenant.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tenants }
    end
  end

  # GET /tenants/1
  # GET /tenants/1.xml
  def show
    @tenant = Tenant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tenant }
    end
  end

  # GET /tenants/new
  # GET /tenants/new.xml
  def new
    @tenant = Tenant.new(:location_id => params[:location_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tenant }
    end
  end

  # GET /tenants/1/edit
  def edit
    @tenant = Tenant.find(params[:id])
  end

  # POST /tenants
  # POST /tenants.xml
  def create
    @tenant = Tenant.new(params[:tenant])

    respond_to do |format|
      if @tenant.save
        flash[:notice] = 'Tenant was successfully created.'
        format.html { redirect_to(@tenant) }
        format.xml  { render :xml => @tenant, :status => :created, :location => @tenant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tenant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tenants/1
  # PUT /tenants/1.xml
  def update
    @tenant = Tenant.find(params[:id])

    respond_to do |format|
      if @tenant.update_attributes(params[:tenant])
        flash[:notice] = 'Tenant was successfully updated.'
        format.html { redirect_to(@tenant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tenant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tenants/1
  # DELETE /tenants/1.xml
  def destroy
    @tenant = Tenant.find(params[:id])
    @tenant.destroy

    respond_to do |format|
      format.html { redirect_to(tenants_url) }
      format.xml  { head :ok }
    end
  end
end
