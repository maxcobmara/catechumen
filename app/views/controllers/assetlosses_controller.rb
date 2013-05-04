class AssetlossesController < ApplicationController
  # GET /assetlosses
  # GET /assetlosses.xml
  def index
    @assetlosses = Assetloss.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assetlosses }
    end
  end

  # GET /assetlosses/1
  # GET /assetlosses/1.xml
  def show
    @assetloss = Assetloss.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assetloss }
    end
  end

  # GET /assetlosses/new
  # GET /assetlosses/new.xml
  def new
    @assetloss = Assetloss.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assetloss }
    end
  end

  # GET /assetlosses/1/edit
  def edit
    @assetloss = Assetloss.find(params[:id])
  end

  # POST /assetlosses
  # POST /assetlosses.xml
  def create
    @assetloss = Assetloss.new(params[:assetloss])

    respond_to do |format|
      if @assetloss.save
        flash[:notice] = 'Assetloss was successfully created.'
        format.html { redirect_to(@assetloss) }
        format.xml  { render :xml => @assetloss, :status => :created, :location => @assetloss }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assetloss.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assetlosses/1
  # PUT /assetlosses/1.xml
  def update
    @assetloss = Assetloss.find(params[:id])

    respond_to do |format|
      if @assetloss.update_attributes(params[:assetloss])
        flash[:notice] = 'Assetloss was successfully updated.'
        format.html { redirect_to(@assetloss) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assetloss.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assetlosses/1
  # DELETE /assetlosses/1.xml
  def destroy
    @assetloss = Assetloss.find(params[:id])
    @assetloss.destroy

    respond_to do |format|
      format.html { redirect_to(assetlosses_url) }
      format.xml  { head :ok }
    end
  end
end
