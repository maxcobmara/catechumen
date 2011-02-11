class SdiciplinesController < ApplicationController
  # GET /sdiciplines
  # GET /sdiciplines.xml
  def index
    @sdiciplines = Sdicipline.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sdiciplines }
    end
  end

  # GET /sdiciplines/1
  # GET /sdiciplines/1.xml
  def show
    @sdicipline = Sdicipline.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sdicipline }
    end
  end

  # GET /sdiciplines/new
  # GET /sdiciplines/new.xml
  def new
    @sdicipline = Sdicipline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sdicipline }
    end
  end

  # GET /sdiciplines/1/edit
  def edit
    @sdicipline = Sdicipline.find(params[:id])
  end

  # POST /sdiciplines
  # POST /sdiciplines.xml
  def create
    @sdicipline = Sdicipline.new(params[:sdicipline])

    respond_to do |format|
      if @sdicipline.save
        flash[:notice] = 'Sdicipline was successfully created.'
        format.html { redirect_to(@sdicipline) }
        format.xml  { render :xml => @sdicipline, :status => :created, :location => @sdicipline }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sdicipline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sdiciplines/1
  # PUT /sdiciplines/1.xml
  def update
    @sdicipline = Sdicipline.find(params[:id])

    respond_to do |format|
      if @sdicipline.update_attributes(params[:sdicipline])
        flash[:notice] = 'Sdicipline was successfully updated.'
        format.html { redirect_to(@sdicipline) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sdicipline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sdiciplines/1
  # DELETE /sdiciplines/1.xml
  def destroy
    @sdicipline = Sdicipline.find(params[:id])
    @sdicipline.destroy

    respond_to do |format|
      format.html { redirect_to(sdiciplines_url) }
      format.xml  { head :ok }
    end
  end
end
