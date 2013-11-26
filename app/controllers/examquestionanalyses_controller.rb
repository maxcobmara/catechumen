class ExamquestionanalysesController < ApplicationController
  # GET /examquestionanalyses
  # GET /examquestionanalyses.xml
  def index
    @examquestionanalyses = Examquestionanalysis.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examquestionanalyses }
    end
  end

  # GET /examquestionanalyses/1
  # GET /examquestionanalyses/1.xml
  def show
    @examquestionanalysis = Examquestionanalysis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examquestionanalysis }
    end
  end

  # GET /examquestionanalyses/new
  # GET /examquestionanalyses/new.xml
  def new
    @examquestionanalysis = Examquestionanalysis.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examquestionanalysis }
    end
  end

  # GET /examquestionanalyses/1/edit
  def edit
    @examquestionanalysis = Examquestionanalysis.find(params[:id])
  end

  # POST /examquestionanalyses
  # POST /examquestionanalyses.xml
  def create
    @examquestionanalysis = Examquestionanalysis.new(params[:examquestionanalysis])

    respond_to do |format|
      if @examquestionanalysis.save
        format.html { redirect_to(@examquestionanalysis, :notice => 'Examquestionanalysis was successfully created.') }
        format.xml  { render :xml => @examquestionanalysis, :status => :created, :location => @examquestionanalysis }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examquestionanalysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examquestionanalyses/1
  # PUT /examquestionanalyses/1.xml
  def update
    @examquestionanalysis = Examquestionanalysis.find(params[:id])

    respond_to do |format|
      if @examquestionanalysis.update_attributes(params[:examquestionanalysis])
        format.html { redirect_to(@examquestionanalysis, :notice => 'Examquestionanalysis was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examquestionanalysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examquestionanalyses/1
  # DELETE /examquestionanalyses/1.xml
  def destroy
    @examquestionanalysis = Examquestionanalysis.find(params[:id])
    @examquestionanalysis.destroy

    respond_to do |format|
      format.html { redirect_to(examquestionanalyses_url) }
      format.xml  { head :ok }
    end
  end
end
