class LessonplanMethodologiesController < ApplicationController
  # GET /lessonplan_methodologies
  # GET /lessonplan_methodologies.xml
  def index
    @lessonplan_methodologies = LessonplanMethodology.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lessonplan_methodologies }
    end
  end

  # GET /lessonplan_methodologies/1
  # GET /lessonplan_methodologies/1.xml
  def show
    @lessonplan_methodology = LessonplanMethodology.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lessonplan_methodology }
    end
  end

  # GET /lessonplan_methodologies/new
  # GET /lessonplan_methodologies/new.xml
  def new
    @lessonplan_methodology = LessonplanMethodology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lessonplan_methodology }
    end
  end

  # GET /lessonplan_methodologies/1/edit
  def edit
    @lessonplan_methodology = LessonplanMethodology.find(params[:id])
  end

  # POST /lessonplan_methodologies
  # POST /lessonplan_methodologies.xml
  def create
    @lessonplan_methodology = LessonplanMethodology.new(params[:lessonplan_methodology])

    respond_to do |format|
      if @lessonplan_methodology.save
        format.html { redirect_to(@lessonplan_methodology, :notice => 'LessonplanMethodology was successfully created.') }
        format.xml  { render :xml => @lessonplan_methodology, :status => :created, :location => @lessonplan_methodology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lessonplan_methodology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lessonplan_methodologies/1
  # PUT /lessonplan_methodologies/1.xml
  def update
    @lessonplan_methodology = LessonplanMethodology.find(params[:id])

    respond_to do |format|
      if @lessonplan_methodology.update_attributes(params[:lessonplan_methodology])
        format.html { redirect_to(@lessonplan_methodology, :notice => 'LessonplanMethodology was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lessonplan_methodology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lessonplan_methodologies/1
  # DELETE /lessonplan_methodologies/1.xml
  def destroy
    @lessonplan_methodology = LessonplanMethodology.find(params[:id])
    @lessonplan_methodology.destroy

    respond_to do |format|
      format.html { redirect_to(lessonplan_methodologies_url) }
      format.xml  { head :ok }
    end
  end
end
