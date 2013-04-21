class ExamanswersController < ApplicationController
  # GET /examanswers
  # GET /examanswers.xml
  def index
    @examanswers = Examanswer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examanswers }
    end
  end

  # GET /examanswers/1
  # GET /examanswers/1.xml
  def show
    @examanswer = Examanswer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examanswer }
    end
  end

  # GET /examanswers/new
  # GET /examanswers/new.xml
  def new
    @examanswer = Examanswer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examanswer }
    end
  end

  # GET /examanswers/1/edit
  def edit
    @examanswer = Examanswer.find(params[:id])
  end

  # POST /examanswers
  # POST /examanswers.xml
  def create
    @examanswer = Examanswer.new(params[:examanswer])

    respond_to do |format|
      if @examanswer.save
        format.html { redirect_to(@examanswer, :notice => 'Examanswer was successfully created.') }
        format.xml  { render :xml => @examanswer, :status => :created, :location => @examanswer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examanswer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examanswers/1
  # PUT /examanswers/1.xml
  def update
    @examanswer = Examanswer.find(params[:id])

    respond_to do |format|
      if @examanswer.update_attributes(params[:examanswer])
        format.html { redirect_to(@examanswer, :notice => 'Examanswer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examanswer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examanswers/1
  # DELETE /examanswers/1.xml
  def destroy
    @examanswer = Examanswer.find(params[:id])
    @examanswer.destroy

    respond_to do |format|
      format.html { redirect_to(examanswers_url) }
      format.xml  { head :ok }
    end
  end
end
