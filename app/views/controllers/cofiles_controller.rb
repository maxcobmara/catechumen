class CofilesController < ApplicationController
  # GET /cofiles
  # GET /cofiles.xml
  def index
     @cofiles = Cofile.search(params[:search])
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cofiles }
    end
  end

  # GET /cofiles/1
  # GET /cofiles/1.xml
  def show
    @cofile = Cofile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cofile }
    end
  end

  # GET /cofiles/new
  # GET /cofiles/new.xml
  def new
    @cofile = Cofile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cofile }
    end
  end

  # GET /cofiles/1/edit
  def edit
    @cofile = Cofile.find(params[:id])
  end

  # POST /cofiles
  # POST /cofiles.xml
  def create
    @cofile = Cofile.new(params[:cofile])

    respond_to do |format|
      if @cofile.save
        flash[:notice] = 'Cofile was successfully created.'
        format.html { redirect_to(@cofile) }
        format.xml  { render :xml => @cofile, :status => :created, :location => @cofile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cofiles/1
  # PUT /cofiles/1.xml
  def update
    @cofile = Cofile.find(params[:id])

    respond_to do |format|
      if @cofile.update_attributes(params[:cofile])
        flash[:notice] = 'Cofile was successfully updated.'
        format.html { redirect_to(@cofile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cofiles/1
  # DELETE /cofiles/1.xml
  def destroy
    @cofile = Cofile.find(params[:id])
    @cofile.destroy

    respond_to do |format|
      format.html { redirect_to(cofiles_url) }
      format.xml  { head :ok }
    end
  end
end
