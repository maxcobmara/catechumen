class ResultlinesController < ApplicationController
  # GET /resultlines
  # GET /resultlines.xml
  def index
    @resultlines = Resultline.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resultlines }
    end
  end

  # GET /resultlines/1
  # GET /resultlines/1.xml
  def show
    @resultline = Resultline.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resultline }
    end
  end

  # GET /resultlines/new
  # GET /resultlines/new.xml
  def new
    @resultline = Resultline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resultline }
    end
  end

  # GET /resultlines/1/edit
  def edit
    @resultline = Resultline.find(params[:id])
  end

  # POST /resultlines
  # POST /resultlines.xml
  def create
    @resultline = Resultline.new(params[:resultline])

    respond_to do |format|
      if @resultline.save
        format.html { redirect_to(@resultline, :notice => 'Resultline was successfully created.') }
        format.xml  { render :xml => @resultline, :status => :created, :location => @resultline }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resultline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resultlines/1
  # PUT /resultlines/1.xml
  def update
    @resultline = Resultline.find(params[:id])



    respond_to do |format|
      if @resultline.update_attributes(params[:resultline])
        format.html { redirect_to(@resultline, :notice => 'Resultline was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resultline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resultlines/1
  # DELETE /resultlines/1.xml
  def destroy
    @resultline = Resultline.find(params[:id])
    @resultline.destroy

    respond_to do |format|
      format.html { redirect_to(resultlines_url) }
      format.xml  { head :ok }
    end
  end
end
