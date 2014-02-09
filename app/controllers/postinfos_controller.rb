class PostinfosController < ApplicationController
  # GET /postinfos
  # GET /postinfos.xml
  def index
    @postinfos = Postinfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @postinfos }
    end
  end

  # GET /postinfos/1
  # GET /postinfos/1.xml
  def show
    @postinfo = Postinfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @postinfo }
    end
  end

  # GET /postinfos/new
  # GET /postinfos/new.xml
  def new
    @postinfo = Postinfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @postinfo }
    end
  end

  # GET /postinfos/1/edit
  def edit
    @postinfo = Postinfo.find(params[:id])
  end

  # POST /postinfos
  # POST /postinfos.xml
  def create
    @postinfo = Postinfo.new(params[:postinfo])

    respond_to do |format|
      if @postinfo.save
        format.html { redirect_to(@postinfo, :notice => 'Postinfo was successfully created.') }
        format.xml  { render :xml => @postinfo, :status => :created, :location => @postinfo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @postinfo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /postinfos/1
  # PUT /postinfos/1.xml
  def update
    @postinfo = Postinfo.find(params[:id])

    respond_to do |format|
      if @postinfo.update_attributes(params[:postinfo])
        format.html { redirect_to(@postinfo, :notice => 'Postinfo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @postinfo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /postinfos/1
  # DELETE /postinfos/1.xml
  def destroy
    @postinfo = Postinfo.find(params[:id])
    @postinfo.destroy

    respond_to do |format|
      format.html { redirect_to(postinfos_url) }
      format.xml  { head :ok }
    end
  end
end
