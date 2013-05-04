class AssetcategoriesController < ApplicationController
  # GET /assetcategories
  # GET /assetcategories.xml
  def index
    @assetcategories = Assetcategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assetcategories }
    end
  end

  # GET /assetcategories/1
  # GET /assetcategories/1.xml
  def show
    @assetcategory = Assetcategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assetcategory }
    end
  end

  # GET /assetcategories/new
  # GET /assetcategories/new.xml
  def new
    @assetcategory = Assetcategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assetcategory }
    end
  end

  # GET /assetcategories/1/edit
  def edit
    @assetcategory = Assetcategory.find(params[:id])
  end

  # POST /assetcategories
  # POST /assetcategories.xml
  def create
    @assetcategory = Assetcategory.new(params[:assetcategory])

    respond_to do |format|
      if @assetcategory.save
        flash[:notice] = 'Assetcategory was successfully created.'
        format.html { redirect_to(@assetcategory) }
        format.xml  { render :xml => @assetcategory, :status => :created, :location => @assetcategory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assetcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assetcategories/1
  # PUT /assetcategories/1.xml
  def update
    @assetcategory = Assetcategory.find(params[:id])

    respond_to do |format|
      if @assetcategory.update_attributes(params[:assetcategory])
        flash[:notice] = 'Assetcategory was successfully updated.'
        format.html { redirect_to(@assetcategory) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assetcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assetcategories/1
  # DELETE /assetcategories/1.xml
  def destroy
    @assetcategory = Assetcategory.find(params[:id])
    @assetcategory.destroy

    respond_to do |format|
      format.html { redirect_to(assetcategories_url) }
      format.xml  { head :ok }
    end
  end
end
