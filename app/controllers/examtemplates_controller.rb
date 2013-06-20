class ExamtemplatesController < ApplicationController
  # GET /examtemplates
  # GET /examtemplates.xml
  def index
    @examtemplates = Examtemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examtemplates }
    end
  end

  # GET /examtemplates/1
  # GET /examtemplates/1.xml
  def show
    @examtemplate = Examtemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examtemplate }
    end
  end

  # GET /examtemplates/new
  # GET /examtemplates/new.xml
  def new
    @examtemplate = Examtemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examtemplate }
    end
  end

  # GET /examtemplates/1/edit
  def edit
    @examtemplate = Examtemplate.find(params[:id])
  end

  # POST /examtemplates
  # POST /examtemplates.xml
  def create
    @examtemplate = Examtemplate.new(params[:examtemplate])

    respond_to do |format|
      if @examtemplate.save
        format.html { redirect_to(@examtemplate, :notice => 'Examtemplate was successfully created.') }
        format.xml  { render :xml => @examtemplate, :status => :created, :location => @examtemplate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examtemplate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examtemplates/1
  # PUT /examtemplates/1.xml
  def update
    @examtemplate = Examtemplate.find(params[:id])

    respond_to do |format|
      if @examtemplate.update_attributes(params[:examtemplate])
        format.html { redirect_to(@examtemplate, :notice => 'Examtemplate was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examtemplate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examtemplates/1
  # DELETE /examtemplates/1.xml
  def destroy
    @examtemplate = Examtemplate.find(params[:id])
    @examtemplate.destroy

    respond_to do |format|
      format.html { redirect_to(examtemplates_url) }
      format.xml  { head :ok }
    end
  end
end
