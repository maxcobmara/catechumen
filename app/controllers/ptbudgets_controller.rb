class PtbudgetsController < ApplicationController
  filter_resource_access
  # GET /ptbudgets
  # GET /ptbudgets.xml
  def index
    @ptbudgets = Ptbudget.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptbudgets }
    end
  end

  # GET /ptbudgets/1
  # GET /ptbudgets/1.xml
  def show
    @ptbudget = Ptbudget.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptbudget }
    end
  end

  # GET /ptbudgets/new
  # GET /ptbudgets/new.xml
  def new
    @ptbudget = Ptbudget.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ptbudget }
    end
  end

  # GET /ptbudgets/1/edit
  def edit
    @ptbudget = Ptbudget.find(params[:id])
  end

  # POST /ptbudgets
  # POST /ptbudgets.xml
  def create
    @ptbudget = Ptbudget.new(params[:ptbudget])

    respond_to do |format|
      if @ptbudget.save
        flash[:notice] = 'Ptbudget was successfully created.'
        format.html { redirect_to(@ptbudget) }
        format.xml  { render :xml => @ptbudget, :status => :created, :location => @ptbudget }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ptbudget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ptbudgets/1
  # PUT /ptbudgets/1.xml
  def update
    @ptbudget = Ptbudget.find(params[:id])

    respond_to do |format|
      if @ptbudget.update_attributes(params[:ptbudget])
        flash[:notice] = 'Ptbudget was successfully updated.'
        format.html { redirect_to(@ptbudget) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ptbudget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptbudgets/1
  # DELETE /ptbudgets/1.xml
  def destroy
    @ptbudget = Ptbudget.find(params[:id])
    @ptbudget.destroy

    respond_to do |format|
      format.html { redirect_to(ptbudgets_url) }
      format.xml  { head :ok }
    end
  end
end
