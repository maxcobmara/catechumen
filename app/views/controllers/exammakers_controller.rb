class ExammakersController < ApplicationController
  # GET /exammakers
  # GET /exammakers.xml
  def index
    @exammakers = Exammaker.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exammakers }
    end
  end

  # GET /exammakers/1
  # GET /exammakers/1.xml
  def show
    @exammaker = Exammaker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exammaker }
    end
  end

  # GET /exammakers/new
  # GET /exammakers/new.xml
  def new
    @exammaker = Exammaker.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exammaker }
    end
  end

  # GET /exammakers/1/edit
  def edit
    @exammaker = Exammaker.find(params[:id])
  end

  # POST /exammakers
  # POST /exammakers.xml
  def create
    @exammaker = Exammaker.new(params[:exammaker])

    respond_to do |format|
      if @exammaker.save
        flash[:notice] = 'Exammaker was successfully created.'
        format.html { redirect_to(@exammaker) }
        format.xml  { render :xml => @exammaker, :status => :created, :location => @exammaker }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exammaker.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exammakers/1
  # PUT /exammakers/1.xml
  def update
    @exammaker = Exammaker.find(params[:id])

    respond_to do |format|
      if @exammaker.update_attributes(params[:exammaker])
        flash[:notice] = 'Exammaker was successfully updated.'
        format.html { redirect_to(@exammaker) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exammaker.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exammakers/1
  # DELETE /exammakers/1.xml
  def destroy
    @exammaker = Exammaker.find(params[:id])
    @exammaker.destroy

    respond_to do |format|
      format.html { redirect_to(exammakers_url) }
      format.xml  { head :ok }
    end
  end
  
  def exampaper
       @exammaker = Exammaker.find(params[:id])  
       #@students = Student.search(params[:search])
       render :layout => 'report'
       #respond_to do |format|
           #format.html # index.html.erb  { render :action => "report.css" }
           #format.xml  { render :xml => @staffs }
       #end
  end
end
