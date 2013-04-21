class ShortessaysController < ApplicationController
  # GET /shortessays
  # GET /shortessays.xml
  def index
    @shortessays = Shortessay.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shortessays }
    end
  end

  # GET /shortessays/1
  # GET /shortessays/1.xml
  def show
    @shortessay = Shortessay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shortessay }
    end
  end

  # GET /shortessays/new
  # GET /shortessays/new.xml
  def new
    @shortessay = Shortessay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shortessay }
    end
  end

  # GET /shortessays/1/edit
  def edit
    @shortessay = Shortessay.find(params[:id])
  end

  # POST /shortessays
  # POST /shortessays.xml
  def create
    @shortessay = Shortessay.new(params[:shortessay])

    respond_to do |format|
      if @shortessay.save
        format.html { redirect_to(@shortessay, :notice => 'Shortessay was successfully created.') }
        format.xml  { render :xml => @shortessay, :status => :created, :location => @shortessay }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shortessay.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shortessays/1
  # PUT /shortessays/1.xml
  def update
    @shortessay = Shortessay.find(params[:id])

    respond_to do |format|
      if @shortessay.update_attributes(params[:shortessay])
        format.html { redirect_to(@shortessay, :notice => 'Shortessay was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shortessay.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shortessays/1
  # DELETE /shortessays/1.xml
  def destroy
    @shortessay = Shortessay.find(params[:id])
    @shortessay.destroy

    respond_to do |format|
      format.html { redirect_to(shortessays_url) }
      format.xml  { head :ok }
    end
  end
end
