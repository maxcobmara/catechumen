class AssetLoansController < ApplicationController
  filter_access_to :all
  # GET /asset_loans
  # GET /asset_loans.xml
  def index
    @asset_loans = AssetLoan.find(:all).sort_by{|item|item.asset_id}
    #@asset_loans = AssetLoan.borrowings
    #-----------
     @filters = AssetLoan::FILTERS
      if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
          @asset_loans = AssetLoan.send(params[:show])#.paginate(:order => :assetcode, :per_page => 30, :page => params[:page])
      else
          @asset_loans = AssetLoan.find(:all).sort_by{|item|item.asset_id}#(:all,:conditions => ['id NOT IN (?) and assetcode ILIKE ? or name ILIKE ? ', loaned, "#{search2}%", "#{search2}%"])#.paginate(:order => :assetcode,  :per_page => 30, :page => params[:page])    
      end
    #-----------
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asset_loans }
    end
  end

  # GET /asset_loans/1
  # GET /asset_loans/1.xml
  def show
    @asset_loan = AssetLoan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset_loan }
    end
  end

  # GET /asset_loans/new
  # GET /asset_loans/new.xml
  def new
    @asset_loan = AssetLoan.new(:asset_id => params[:asset_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset_loan }
    end
  end

  # GET /asset_loans/1/edit
  def edit
    @asset_loan = AssetLoan.find(params[:id])
  end

  # POST /asset_loans
  # POST /asset_loans.xml
  def create
    @asset_loan = AssetLoan.new(params[:asset_loan])

    respond_to do |format|
      if @asset_loan.save
        format.html { redirect_to(@asset_loan, :notice => t('assetloan.title')+" "+t('created')) }
        format.xml  { render :xml => @asset_loan, :status => :created, :location => @asset_loan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset_loan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asset_loans/1
  # PUT /asset_loans/1.xml
  def update
    @asset_loan = AssetLoan.find(params[:id])

    respond_to do |format|
      if @asset_loan.update_attributes(params[:asset_loan])
        format.html { redirect_to(@asset_loan, :notice => t('assetloan.title')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset_loan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_loans/1
  # DELETE /asset_loans/1.xml
  def destroy
    @asset_loan = AssetLoan.find(params[:id])
    @asset_loan.destroy

    respond_to do |format|
      format.html { redirect_to(asset_loans_url) }
      format.xml  { head :ok }
    end
  end
  
  def approve
    @asset_loan = AssetLoan.find(params[:id])
  end
  
  def lampiran
    @asset_loan = AssetLoan.find(params[:id]) #search(params[:search])
    render :layout => 'report'
  end
end
