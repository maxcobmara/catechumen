class BulletinsController < ApplicationController
  # GET /bulletins
  # GET /bulletins.xml
  def index
     @bulletins = Bulletin.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bulletins }
    end
  end

  # GET /bulletins/1
  # GET /bulletins/1.xml
  def show
    @bulletin = Bulletin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bulletin }
    end
  end

  # GET /bulletins/new
  # GET /bulletins/new.xml
  def new
    @bulletin = Bulletin.new
   
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bulletin }
    end
  end

  # GET /bulletins/1/edit
  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  # POST /bulletins
  # POST /bulletins.xml
  def create
    @bulletin = Bulletin.new(params[:bulletin])

    respond_to do |format|
      if @bulletin.save
        flash[:notice] = 'Bulletin was successfully created.'
        format.html { redirect_to(@bulletin) }
        format.xml  { render :xml => @bulletin, :status => :created, :location => @bulletin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bulletin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bulletins/1
  # PUT /bulletins/1.xml
  def update
    @bulletin = Bulletin.find(params[:id])

    respond_to do |format|
      if @bulletin.update_attributes(params[:bulletin])
        flash[:notice] = 'Bulletin was successfully updated.'
        format.html { redirect_to(@bulletin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bulletin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletins/1
  # DELETE /bulletins/1.xml
  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy

    respond_to do |format|
      format.html { redirect_to(bulletins_url) }
      format.xml  { head :ok }
    end
  end
end
