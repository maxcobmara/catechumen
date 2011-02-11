class AssetsController < ApplicationController
  
  # GET /assets
  # GET /assets.xml
  def index
    @assets = Asset.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.xml
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    @asset = Asset.new
    @asset.assetnums.build
    @asset.maints.build
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end
  
  def registerinventory
    #@asset = Asset.find(params[:id])  
    @assets = Asset.search(params[:all])
    @assets = Asset.find(:all, :conditions => {:assettype => '2'})
    render :layout => 'report'
    #respond_to do |format|
        #format.html # index.html.erb  { render :action => "report.css" }
        #format.xml  { render :xml => @staffs }
    #end
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        flash[:notice] = 'Asset was successfully created.'
        format.html { redirect_to(@asset) }
        format.xml  { render :xml => @asset, :status => :created, :location => @asset }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        flash[:notice] = 'Asset was successfully updated.'
        format.html { redirect_to(@asset) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to(assets_url) }
      format.xml  { head :ok }
    end
  end
  
  def accepted_terms
    if params["1"]
      render :partial => "submit_application_button"
    else
      render_text "You cannot continue without agreeing to the Terms and Conditions."
    end
  end
end
