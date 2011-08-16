class AccessionsController < ApplicationController
  # GET /accessions
  # GET /accessions.xml
  def index
    @accessions = Accession.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accessions }
    end
  end

  # GET /accessions/1
  # GET /accessions/1.xml
  def show
    @accession = Accession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @accession }
    end
  end

  # GET /accessions/new
  # GET /accessions/new.xml
  def new
    @accession = Accession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @accession }
    end
  end

  # GET /accessions/1/edit
  def edit
    @accession = Accession.find(params[:id])
  end

  # POST /accessions
  # POST /accessions.xml
  def create
    @accession = Accession.new(params[:accession])

    respond_to do |format|
      if @accession.save
        flash[:notice] = 'Accession was successfully created.'
        format.html { redirect_to(@accession) }
        format.xml  { render :xml => @accession, :status => :created, :location => @accession }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @accession.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accessions/1
  # PUT /accessions/1.xml
  def update
    @accession = Accession.find(params[:id])

    respond_to do |format|
      if @accession.update_attributes(params[:accession])
        flash[:notice] = 'Accession was successfully updated.'
        format.html { redirect_to(@accession) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @accession.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accessions/1
  # DELETE /accessions/1.xml
  def destroy
    @accession = Accession.find(params[:id])
    @accession.destroy

    respond_to do |format|
      format.html { redirect_to(accessions_url) }
      format.xml  { head :ok }
    end
  end
end
