class AssetLossesController < ApplicationController
  filter_access_to :all
  #filter_resource_access
  # GET /asset_losses
  # GET /asset_losses.xml
  def index
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:authname)
    @is_admin=true if current_roles.include?("administration") || current_roles.include?("asset_losses_module_admin")|| current_roles.include?("asset_losses_module_viewer")|| current_roles.include?("asset_losses_module_user")
    @asset_losses = AssetLoss.with_permissions_to(:kewpa28).all #find(:all)#, :order => 'lost_at DESC')
    @asset_losses_group_writeoff = @asset_losses.group_by{|x|x.document_id}
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
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:authname)
    @is_admin=true if current_roles.include?("administration") || current_roles.include?("asset_losses_module_admin")|| current_roles.include?("asset_losses_module_viewer")|| current_roles.include?("asset_losses_module_user")
  end

  # POST /asset_losses
  # POST /asset_losses.xml
  def create
    @asset_loss = AssetLoss.new(params[:asset_loss])

    respond_to do |format|
      if @asset_loss.save
        format.html { redirect_to(@asset_loss, :notice => t('asset_losses.title')+" "+t('created')) }
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
        format.html { redirect_to(@asset_loss, :notice =>  t('asset_losses.title')+" "+t('updated')) }
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

  def kewpa31
    #@asset_loss = AssetLoss.find(params[:id])
    #@asset_losses = AssetLoss.find(:all, :order => 'created_at DESC')
    @document_id = params[:id]
    @asset_losses = AssetLoss.find(:all, :conditions=>['document_id=?', @document_id], :order => 'created_at DESC') 
    render :layout => 'report'
  end
  
    #def writeoff
    #@asset_loss = AssetLoss.find(params[:id])
  #end
  
  
  def edit_multiple
    #raise params.inspect
    @assetlosses_ids = params[:asset_loss_ids]
    unless @assetlosses_ids.blank? 
 	      @asset_losses = AssetLoss.find(@assetlosses_ids)
 	      @asset_losses_count = @asset_losses.count
 	      @asset_losses_docs_count = @asset_losses.map(&:endorsed_on).count
 	      @edit_type = params[:grade_submit_button]
		    if @edit_type == I18n.t('asset_losses.writeoff_checked') && (@asset_losses_count == @asset_losses_docs_count)
 	          ## continue multiple edit (including subject edit here) --> refer view
 	      else
 	          flash[:error] = I18n.t('asset_losses.hod_endorsement_compulsory')
 	          redirect_to asset_losses_path
        end    # end for if @edit_type=="Edit Checked"
    else    
        flash[:notice] = I18n.t('select_one')
        redirect_to asset_losses_path
    end
  end
  
  def update_multiple
    #raise params.inspect
    @assetlosses_ids = params[:asset_loss_ids]
    @document_id = params[:asset_loss][:document_id]
    @asset_losses = AssetLoss.find(@assetlosses_ids)	
    
    @asset_losses.each_with_index do |asset_loss, index| 
        asset_loss.is_writeoff = true
        asset_loss.document_id = @document_id 
    		asset_loss.save
   	end			

   	flash[:notice] = I18n.t('asset_losses.writeoff_updated')
    redirect_to asset_losses_path
   
  end
end
