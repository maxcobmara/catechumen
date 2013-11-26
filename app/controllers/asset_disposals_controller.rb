class AssetDisposalsController < ApplicationController
  # GET /asset_disposals
  # GET /asset_disposals.xml
  def index
    @asset_disposals = AssetDisposal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asset_disposals }
    end
  end

  # GET /asset_disposals/1
  # GET /asset_disposals/1.xml
  def show
    @asset_disposal = AssetDisposal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset_disposal }
    end
  end

  # GET /asset_disposals/new
  # GET /asset_disposals/new.xml
  def new
    @asset_disposal = AssetDisposal.new(:asset_id => params[:asset_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset_disposal }
    end
  end

  # GET /asset_disposals/1/edit
  def edit
    @asset_disposal = AssetDisposal.find(params[:id])
  end

  # POST /asset_disposals
  # POST /asset_disposals.xml
  def create
    @asset_disposal = AssetDisposal.new(params[:asset_disposal])

    respond_to do |format|
      if @asset_disposal.save
        format.html { redirect_to(@asset_disposal, :notice => 'Disposal was succesfully registered.') }
        format.xml  { render :xml => @asset_disposal, :status => :created, :location => @asset_disposal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset_disposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asset_disposals/1
  # PUT /asset_disposals/1.xml
  def update
    @asset_disposal = AssetDisposal.find(params[:id])

    respond_to do |format|
      if @asset_disposal.update_attributes(params[:asset_disposal])
        format.html { redirect_to(@asset_disposal, :notice => 'Disposal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset_disposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_disposals/1
  # DELETE /asset_disposals/1.xml
  def destroy
    @asset_disposal = AssetDisposal.find(params[:id])
    @asset_disposal.destroy

    respond_to do |format|
      format.html { redirect_to(asset_disposals_url) }
      format.xml  { head :ok }
    end
  end
  
  def kewpa17
    @asset_disposals = AssetDisposal.find(:all, :order => 'created_at DESC')
    render :layout => 'report'
  end
  
  def kewpa20
    @asset_disposals = AssetDisposal.find(:all, :order => 'created_at DESC')
    render :layout => 'report'
  end
  
  def kewpa16
    @asset_disposal = AssetDisposal.find(params[:id])
    render :layout => 'report'
  end
  
  def kewpa18
    @asset_disposal = AssetDisposal.find(params[:id])
    render :layout => 'report'
  end
  
  def kewpa19
    @asset_disposal = AssetDisposal.find(params[:id])
    render :layout => 'report'
  end
  
  def revalue
    @asset_disposal = AssetDisposal.find(params[:id])
  end
  
  def dispose
    @asset_disposal = AssetDisposal.find(params[:id])
  end
end
