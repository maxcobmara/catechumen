class StafftitlesController < ApplicationController
  # GET /stafftitles
  # GET /stafftitles.xml
  def index
    @stafftitles = Stafftitle.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stafftitles }
    end
  end

  # GET /stafftitles/1
  # GET /stafftitles/1.xml
  def show
    @stafftitle = Stafftitle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stafftitle }
    end
  end

  # GET /stafftitles/new
  # GET /stafftitles/new.xml
  def new
    @stafftitle = Stafftitle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stafftitle }
    end
  end

  # GET /stafftitles/1/edit
  def edit
    @stafftitle = Stafftitle.find(params[:id])
  end

  # POST /stafftitles
  # POST /stafftitles.xml
  def create
    @stafftitle = Stafftitle.new(params[:stafftitle])

    respond_to do |format|
      if @stafftitle.save
        flash[:notice] = 'Stafftitle was successfully created.'
        format.html { redirect_to(@stafftitle) }
        format.xml  { render :xml => @stafftitle, :status => :created, :location => @stafftitle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stafftitle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stafftitles/1
  # PUT /stafftitles/1.xml
  def update
    @stafftitle = Stafftitle.find(params[:id])

    respond_to do |format|
      if @stafftitle.update_attributes(params[:stafftitle])
        flash[:notice] = 'Stafftitle was successfully updated.'
        format.html { redirect_to(@stafftitle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stafftitle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stafftitles/1
  # DELETE /stafftitles/1.xml
  def destroy
    @stafftitle = Stafftitle.find(params[:id])
    @stafftitle.destroy

    respond_to do |format|
      format.html { redirect_to(stafftitles_url) }
      format.xml  { head :ok }
    end
  end
end
