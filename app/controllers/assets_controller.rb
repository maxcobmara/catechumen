class AssetsController < ApplicationController
  
  # GET /assets
  # GET /assets.xml
  def index
    #@assets = Asset.search(params[:search]).paginate(:per_page => 30, :page => params[:page])
    #@asset_gbtype = @assets.group_by { |t| t.gbtype }
    @filters = Asset::FILTERS
      if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
        @assets = Asset.send(params[:show]).paginate(:order => :assetcode, :per_page => 30, :page => params[:page])
        @asset_gbtype = @assets.group_by { |t| t.gbtype }
      else
        @assets = Asset.search(params[:search]).paginate(:order => :assetcode,  :per_page => 30, :page => params[:page])
        @asset_gbtype = @assets.group_by { |t| t.gbtype }
      end
      
    @assetforloss = Asset.find(:all, :conditions => ['name ILIKE ?', "%#{params[:search]}%"], :order => :assetcode)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
      format.js   { render :js => @assetforloss }
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
    #@asset.assetnums.build
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
    @assets = Asset.search(params[:search])
    #@assets = Asset.find(:all, :conditions => {:assettype => '2'})
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
        flash[:notice] = 'Asset was successfully registered.'
        format.html { redirect_to (@asset) }
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
  
  
  def maintenance
    @asset = Asset.find(params[:id])  
  end
  
  def asset_placement
    @asset = Asset.find(params[:id])  
  end
  
  def kewpa3
    @asset = Asset.find(params[:id])
    render :layout => 'report'
  end
  
  def kewpa2
    @asset = Asset.find(params[:id])
    render :layout => 'report'
  end
  
  def accepted_terms
    if params["1"]
      render :partial => "submit_application_button"
    else
      render_text "You cannot continue without agreeing to the Terms and Conditions."
    end
  end
  
  def kewpa4
    if params[:search]
        @assets = Asset.find(:all, :conditions => ['substring(assetcode, 18, 2 ) =? AND assettype =?', "#{params[:search]}", 1])
    else
        @assets = Asset.find(:all, :conditions => ['assettype =?',  1])
    end
    render :layout => 'report'
  end
  
  def kewpa8
    @asset = Asset.all #search(params[:search])
    render :layout => 'report'
  end
  
  def kewpa13
    @assets = Asset.find(:all, :conditions => ['is_maintainable = ?', true], :order => 'assetcode ASC')
    render :layout => 'report'
  end
  
  def kewpa14
    @asset = Asset.find(params[:id])
    render :layout => 'report'
  end

  def kewpa6
    #display historic & potential loaner
    @asset = Asset.find(params[:id])
    @loanable = AssetLoan.find(:all, :conditions => ['asset_id=? AND is_approved!=?',params[:id], false], :order=>'returned_on ASC')
    render :layout => 'report'
  end
  
  
  def asset_autocomplete
    @asset_autocompletes = Asset.find(:all, :conditions => ['assetcode ILIKE ? OR name ILIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"])
    #@boo = Asset.find(:all, :conditions => ['assetcode ILIKE ? OR name ILIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"])
    #@asset_autocompletes = @boo.each do |asset| {asset_list << [assetcode, name]}
    
    respond_to do |format|
      format.js   { render :js => @asset_autocomplete }
    end
  end
  
  def loanables
    #@loanables = Asset.on_loan
    #@loanables = Asset.on_loan.paginate(:per_page => 30, :page => params[:page])
    #@loanables = Asset.on_loan.search(params[:search]).paginate(:order => :assetcode,  :per_page => 30, :page => params[:page])
    
    search2=params[:search]
    #--from Asset.on_loan
    loaned = AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id) #23Apr2013
    if loaned == []
        loaned = [0]
    end
    #--from Asset.on_loan

    dept = Position.find(:first, :conditions=>['unit=?',"Teknologi Maklumat"]).subtree.map(&:staff_id)
    #dept = Position.find(:first, :conditions=>['unit=?',"#{search2}%"]).subtree.map(&:staff_id)
    
    #yg ok-in case-----
    @loanables = Asset.find(:all,:conditions => ['id NOT IN (?) and assetcode ILIKE ? or name ILIKE ? ', loaned, "#{search2}%", "#{search2}%"]).paginate(:order => :assetcode,  :per_page => 30, :page => params[:page])    
    #yg ok-in case-----
    #@loanables = Asset.find(:all,:conditions => ['id NOT IN (?) and assetcode ILIKE ? or name ILIKE ? ', loaned, "#{search2}%", "#{search2}%"]).paginate(:order => :assetcode,  :per_page => 30, :page => params[:page])    
    @loanables_with_assignedto = Asset.find(:all,:conditions => ['id NOT IN (?) and assignedto_id is not null or assetcode ILIKE ? or name ILIKE ? ', loaned, "#{search2}%", "#{search2}%"])
    @loanables_with_assignedto_dept = Asset.find(:all,:conditions => ['id NOT IN (?) and assignedto_id in (?) or assetcode ILIKE ? or name ILIKE ? ', loaned, [25,67,59], "#{search2}%", "#{search2}%"])
    @loanables_with_assignedto_dept2= Asset.find(:all,:conditions => ['id NOT IN (?) and assignedto_id in (?) or assetcode ILIKE ? or name ILIKE ? ', loaned, dept, "#{search2}%", "#{search2}%"])
  
    #++++++++++++++++++++++++++++++++++++++++++++++filter loanables based on dept/unit
    @filters = Asset::FILTERS_LOAN
    if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
        @loanables = Asset.send(params[:show]).paginate(:order => :assetcode, :per_page => 30, :page => params[:page])
    else
        @loanables = Asset.find(:all,:conditions => ['id NOT IN (?) and assetcode ILIKE ? or name ILIKE ? ', loaned, "#{search2}%", "#{search2}%"]).paginate(:order => :assetcode,  :per_page => 30, :page => params[:page])    
        #@loanables = Asset.search(params[:search]).paginate(:order => :assetcode,  :per_page => 30, :page => params[:page])
        #@asset_gbtype = @assets.group_by { |t| t.gbtype }
    end
    #++++++++++++++++++++++++++++++++++++++++++++++filter loanables based on dept/unit
  end
  
end
