class AppraisalsController < ApplicationController
  # GET /appraisals
  # GET /appraisals.xml
  def index
    @appraisals = Appraisal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @appraisals }
    end
  end

  # GET /appraisals/1
  # GET /appraisals/1.xml
  def show
    @appraisal = Appraisal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @appraisal }
    end
  end

  # GET /appraisals/new
  # GET /appraisals/new.xml
  def new
    @appraisal = Appraisal.new
    2.times { @appraisal.evactivities.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @appraisal }
    end
  end
  
  def recalc_totals
    appraisal = Appraisal.find(params[:id])
    @appraisal.add_totals(appraisal)
    
    

    respond_to do |format|
      #format.js
      redirect_to :action => 'edit'
    end
    
    
  end
    

  # GET /appraisals/1/edit
  def edit
    @appraisal = Appraisal.find(params[:id])
  end

  # POST /appraisals
  # POST /appraisals.xml
  def create
    @appraisal = Appraisal.new(params[:appraisal])

    respond_to do |format|
      if @appraisal.save
        flash[:notice] = 'Appraisal was successfully created.'
        format.html { redirect_to(@appraisal) }
        format.xml  { render :xml => @appraisal, :status => :created, :location => @appraisal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @appraisal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /appraisals/1
  # PUT /appraisals/1.xml
  def update
    @appraisal = Appraisal.find(params[:id])

    respond_to do |format|
      if @appraisal.update_attributes(params[:appraisal])
        flash[:notice] = 'Appraisal was successfully updated.'
        format.html { redirect_to(@appraisal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @appraisal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /appraisals/1
  # DELETE /appraisals/1.xml
  def destroy
    @appraisal = Appraisal.find(params[:id])
    @appraisal.destroy

    respond_to do |format|
      format.html { redirect_to(appraisals_url) }
      format.xml  { head :ok }
    end
  end
end
