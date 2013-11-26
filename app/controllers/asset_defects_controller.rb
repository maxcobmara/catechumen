class AssetDefectsController < ApplicationController
  filter_access_to :all
  
  # GET /asset_defects
  # GET /asset_defects.xml
  def index
    @asset_defects = AssetDefect.with_permissions_to(:index).find(:all, :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asset_defects }
    end
  end

  # GET /asset_defects/1
  # GET /asset_defects/1.xml
  def show
    @asset_defect = AssetDefect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset_defect }
    end
  end

  # GET /asset_defects/new
  # GET /asset_defects/new.xml
  def new
    @asset_defect = AssetDefect.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset_defect }
    end
  end

  # GET /asset_defects/1/edit
  def edit
    @asset_defect = AssetDefect.find(params[:id])
  end

  # POST /asset_defects
  # POST /asset_defects.xml
  def create
    @asset_defect = AssetDefect.new(params[:asset_defect])

    respond_to do |format|
      if @asset_defect.save
        format.html { redirect_to(@asset_defect, :notice => 'AssetDefect was successfully created.') }
        format.xml  { render :xml => @asset_defect, :status => :created, :location => @asset_defect }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset_defect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asset_defects/1
  # PUT /asset_defects/1.xml
  def update
    @asset_defect = AssetDefect.find(params[:id])

    respond_to do |format|
      if @asset_defect.update_attributes(params[:asset_defect])
        format.html { redirect_to(@asset_defect, :notice => 'AssetDefect was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset_defect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_defects/1
  # DELETE /asset_defects/1.xml
  def destroy
    @asset_defect = AssetDefect.find(params[:id])
    @asset_defect.destroy

    respond_to do |format|
      format.html { redirect_to(asset_defects_url) }
      format.xml  { head :ok }
    end
  end
  
  def approve
    @asset_defect = AssetDefect.find(params[:id])
  end
  
  def kewpa9
    @asset_defect = AssetDefect.find(params[:id])
    render :layout => 'report'
  end
  
  def kewpa13
    #@asset_defects = AssetDefect.find(:all, :order => 'created_at DESC')
    @asset_defects = AssetDefect.find(:all,:conditions=>['process_type=?','repair'], :order => 'created_at DESC')
    render :layout => 'report'
  end
  
  
end
