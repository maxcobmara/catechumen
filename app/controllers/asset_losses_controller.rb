class AssetLossesController < ApplicationController
  # GET /asset_losses
  # GET /asset_losses.xml
  def index
    @asset_losses = AssetLoss.find(:all, :order => 'lost_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asset_losses }
    end
  end

  # GET /asset_losses/1
  # GET /asset_losses/1.xml
  def show
    @asset_loss = AssetLoss.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset_loss }
    end
  end

  # GET /asset_losses/new
  # GET /asset_losses/new.xml
  def new
    @asset_loss = AssetLoss.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset_loss }
    end
  end

  # GET /asset_losses/1/edit
  def edit
    @asset_loss = AssetLoss.find(params[:id])
  end

  # POST /asset_losses
  # POST /asset_losses.xml
  def create
    @asset_loss = AssetLoss.new(params[:asset_loss])

    respond_to do |format|
      if @asset_loss.save
        format.html { redirect_to(@asset_loss, :notice => 'AssetLoss was successfully created.') }
        format.xml  { render :xml => @asset_loss, :status => :created, :location => @asset_loss }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset_loss.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asset_losses/1
  # PUT /asset_losses/1.xml
  def update
    @asset_loss = AssetLoss.find(params[:id])

    respond_to do |format|
      if @asset_loss.update_attributes(params[:asset_loss])
        format.html { redirect_to(@asset_loss, :notice => 'AssetLoss was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset_loss.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_losses/1
  # DELETE /asset_losses/1.xml
  def destroy
    @asset_loss = AssetLoss.find(params[:id])
    @asset_loss.destroy

    respond_to do |format|
      format.html { redirect_to(asset_losses_url) }
      format.xml  { head :ok }
    end
  end
  
  def kewpa28
    @asset_loss = AssetLoss.find(params[:id])
    render :layout => 'report'
  end
  
  def kewpa30
    @asset_loss = AssetLoss.find(params[:id])
    render :layout => 'report'
  end
end
