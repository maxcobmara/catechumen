class LoansController < ApplicationController
  # GET /loans
  # GET /loans.xml
  def index
    @loans = Loan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @loans }
    end
  end

  # GET /loans/1
  # GET /loans/1.xml
  def show
    @loan = Loan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @loan }
    end
  end

  # GET /loans/new
  # GET /loans/new.xml
  def new
    @loan = Loan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @loan }
    end
  end

  # GET /loans/1/edit
  def edit
    @loan = Loan.find(params[:id])
  end

  # POST /loans
  # POST /loans.xml
  def create
    @loan = Loan.new(params[:loan])

    respond_to do |format|
      if @loan.save
        flash[:notice] = 'Loan was successfully created.'
        format.html { redirect_to(@loan) }
        format.xml  { render :xml => @loan, :status => :created, :location => @loan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @loan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /loans/1
  # PUT /loans/1.xml
  def update
    @loan = Loan.find(params[:id])

    respond_to do |format|
      if @loan.update_attributes(params[:loan])
        flash[:notice] = 'Loan was successfully updated.'
        format.html { redirect_to(@loan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @loan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.xml
  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy

    respond_to do |format|
      format.html { redirect_to(loans_url) }
      format.xml  { head :ok }
    end
  end
end
