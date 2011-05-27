class StaffserveschemesController < ApplicationController
  # GET /staffserveschemes
  # GET /staffserveschemes.xml
  def index
    @staffserveschemes = Staffservescheme.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffserveschemes }
    end
  end

  # GET /staffserveschemes/1
  # GET /staffserveschemes/1.xml
  def show
    @staffservescheme = Staffservescheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffservescheme }
    end
  end

  # GET /staffserveschemes/new
  # GET /staffserveschemes/new.xml
  def new
    @staffservescheme = Staffservescheme.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffservescheme }
    end
  end

  # GET /staffserveschemes/1/edit
  def edit
    @staffservescheme = Staffservescheme.find(params[:id])
  end

  # POST /staffserveschemes
  # POST /staffserveschemes.xml
  def create
    @staffservescheme = Staffservescheme.new(params[:staffservescheme])

    respond_to do |format|
      if @staffservescheme.save
        flash[:notice] = 'Staffservescheme was successfully created.'
        format.html { redirect_to(@staffservescheme) }
        format.xml  { render :xml => @staffservescheme, :status => :created, :location => @staffservescheme }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staffservescheme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffserveschemes/1
  # PUT /staffserveschemes/1.xml
  def update
    @staffservescheme = Staffservescheme.find(params[:id])

    respond_to do |format|
      if @staffservescheme.update_attributes(params[:staffservescheme])
        flash[:notice] = 'Staffservescheme was successfully updated.'
        format.html { redirect_to(@staffservescheme) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staffservescheme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffserveschemes/1
  # DELETE /staffserveschemes/1.xml
  def destroy
    @staffservescheme = Staffservescheme.find(params[:id])
    @staffservescheme.destroy

    respond_to do |format|
      format.html { redirect_to(staffserveschemes_url) }
      format.xml  { head :ok }
    end
  end
end
