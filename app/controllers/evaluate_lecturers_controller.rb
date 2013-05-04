class EvaluateLecturersController < ApplicationController
  # GET /evaluate_lecturers
  # GET /evaluate_lecturers.xml
  def index
    @evaluate_lecturers = EvaluateLecturer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @evaluate_lecturers }
    end
  end

  # GET /evaluate_lecturers/1
  # GET /evaluate_lecturers/1.xml
  def show
    @evaluate_lecturer = EvaluateLecturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evaluate_lecturer }
    end
  end

  # GET /evaluate_lecturers/new
  # GET /evaluate_lecturers/new.xml
  def new
    @evaluate_lecturer = EvaluateLecturer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evaluate_lecturer }
    end
  end

  # GET /evaluate_lecturers/1/edit
  def edit
    @evaluate_lecturer = EvaluateLecturer.find(params[:id])
  end

  # POST /evaluate_lecturers
  # POST /evaluate_lecturers.xml
  def create
    @evaluate_lecturer = EvaluateLecturer.new(params[:evaluate_lecturer])

    respond_to do |format|
      if @evaluate_lecturer.save
        flash[:notice] = 'EvaluateLecturer was successfully created.'
        format.html { redirect_to(@evaluate_lecturer) }
        format.xml  { render :xml => @evaluate_lecturer, :status => :created, :location => @evaluate_lecturer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evaluate_lecturer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evaluate_lecturers/1
  # PUT /evaluate_lecturers/1.xml
  def update
    @evaluate_lecturer = EvaluateLecturer.find(params[:id])

    respond_to do |format|
      if @evaluate_lecturer.update_attributes(params[:evaluate_lecturer])
        flash[:notice] = 'EvaluateLecturer was successfully updated.'
        format.html { redirect_to(@evaluate_lecturer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evaluate_lecturer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluate_lecturers/1
  # DELETE /evaluate_lecturers/1.xml
  def destroy
    @evaluate_lecturer = EvaluateLecturer.find(params[:id])
    @evaluate_lecturer.destroy

    respond_to do |format|
      format.html { redirect_to(evaluate_lecturers_url) }
      format.xml  { head :ok }
    end
  end
  
  def penilaipensyarah
     @evaluate_lecturer = EvaluateLecturer.find(params[:id])
     render :layout => 'report'
  end
end
