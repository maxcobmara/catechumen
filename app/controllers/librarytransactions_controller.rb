class LibrarytransactionsController < ApplicationController
  # GET /librarytransactions
  # GET /librarytransactions.xml
  #def index
    #@librarytransactions = Librarytransaction.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @librarytransactions }
    #end
  #end
  
  def index
    @filters = Librarytransaction::FILTERS
    if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
      @librarytransactions = Librarytransaction.send(params[:show])
    else
      @librarytransactions = Librarytransaction.all
    end
    @libtran_days =  @librarytransactions.group_by {|t| t.checkoutdate}
  end

  # GET /librarytransactions/1
  # GET /librarytransactions/1.xml
  def show
    @librarytransaction = Librarytransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @librarytransaction }
    end
  end

  # GET /librarytransactions/new
  # GET /librarytransactions/new.xml
  def new
    @librarytransaction = Librarytransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @librarytransaction }
    end
  end

  # GET /librarytransactions/1/edit
  def edit
    @librarytransaction = Librarytransaction.find(params[:id])
  end

  # POST /librarytransactions
  # POST /librarytransactions.xml
  def create
    @librarytransaction = Librarytransaction.new(params[:librarytransaction])

    respond_to do |format|
      if @librarytransaction.save
        flash[:notice] = 'Librarytransaction was successfully created.'
        format.html { redirect_to(@librarytransaction) }
        format.xml  { render :xml => @librarytransaction, :status => :created, :location => @librarytransaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @librarytransaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /librarytransactions/1
  # PUT /librarytransactions/1.xml
  def update
    @librarytransaction = Librarytransaction.find(params[:id])

    respond_to do |format|
      if @librarytransaction.update_attributes(params[:librarytransaction])
        flash[:notice] = 'Librarytransaction was successfully updated.'
        format.html { redirect_to(@librarytransaction) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @librarytransaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /librarytransactions/1
  # DELETE /librarytransactions/1.xml
  def destroy
    @librarytransaction = Librarytransaction.find(params[:id])
    @librarytransaction.destroy

    respond_to do |format|
      format.html { redirect_to(librarytransactions_url) }
      format.xml  { head :ok }
    end
  end
   
  def report_overdue
     @librarytransactions = Librarytransaction.find(:all, :limit => 20)
     @libtran_borrowers =  @librarytransactions.group_by {|t| t.ru_staff}
      render :layout => 'report'
   end
  
   def extend
       @librarytransaction = Librarytransaction.find(params[:id])
  end
  
  def return
      @librarytransaction = Librarytransaction.find(params[:id])
  end
end
