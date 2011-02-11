class DisposalsController < ApplicationController
  # GET /disposals
  # GET /disposals.xml
  def index
    @disposals = Disposal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @disposals }
    end
  end

  # GET /disposals/1
  # GET /disposals/1.xml
  def show
    @disposal = Disposal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @disposal }
    end
  end

  # GET /disposals/new
  # GET /disposals/new.xml
  def new
    @disposal = Disposal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @disposal }
    end
  end

  # GET /disposals/1/edit
  def edit
    @disposal = Disposal.find(params[:id])
  end

  # POST /disposals
  # POST /disposals.xml
  def create
    @disposal = Disposal.new(params[:disposal])

    respond_to do |format|
      if @disposal.save
        flash[:notice] = 'Disposal was successfully created.'
        format.html { redirect_to(@disposal) }
        format.xml  { render :xml => @disposal, :status => :created, :location => @disposal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @disposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /disposals/1
  # PUT /disposals/1.xml
  def update
    @disposal = Disposal.find(params[:id])

    respond_to do |format|
      if @disposal.update_attributes(params[:disposal])
        flash[:notice] = 'Disposal was successfully updated.'
        format.html { redirect_to(@disposal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @disposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /disposals/1
  # DELETE /disposals/1.xml
  def destroy
    @disposal = Disposal.find(params[:id])
    @disposal.destroy

    respond_to do |format|
      format.html { redirect_to(disposals_url) }
      format.xml  { head :ok }
    end
  end
end
