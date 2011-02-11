class CourseevaluationsController < ApplicationController
  # GET /courseevaluations
  # GET /courseevaluations.xml
  def index
    @courseevaluations = Courseevaluation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courseevaluations }
    end
  end

  # GET /courseevaluations/1
  # GET /courseevaluations/1.xml
  def show
    @courseevaluation = Courseevaluation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @courseevaluation }
    end
  end

  # GET /courseevaluations/new
  # GET /courseevaluations/new.xml
  def new
    @courseevaluation = Courseevaluation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @courseevaluation }
    end
  end

  # GET /courseevaluations/1/edit
  def edit
    @courseevaluation = Courseevaluation.find(params[:id])
  end

  # POST /courseevaluations
  # POST /courseevaluations.xml
  def create
    @courseevaluation = Courseevaluation.new(params[:courseevaluation])

    respond_to do |format|
      if @courseevaluation.save
        flash[:notice] = 'Courseevaluation was successfully created.'
        format.html { redirect_to(@courseevaluation) }
        format.xml  { render :xml => @courseevaluation, :status => :created, :location => @courseevaluation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @courseevaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courseevaluations/1
  # PUT /courseevaluations/1.xml
  def update
    @courseevaluation = Courseevaluation.find(params[:id])

    respond_to do |format|
      if @courseevaluation.update_attributes(params[:courseevaluation])
        flash[:notice] = 'Courseevaluation was successfully updated.'
        format.html { redirect_to(@courseevaluation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @courseevaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courseevaluations/1
  # DELETE /courseevaluations/1.xml
  def destroy
    @courseevaluation = Courseevaluation.find(params[:id])
    @courseevaluation.destroy

    respond_to do |format|
      format.html { redirect_to(courseevaluations_url) }
      format.xml  { head :ok }
    end
  end
end
