class ExamresultsController < ApplicationController
  # GET /examresults
  # GET /examresults.xml
  def index
    @examresults = Examresult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examresults }
    end
  end
  
  def index2
    @examresults = Examresult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examresults }
    end
  end

  # GET /examresults/1
  # GET /examresults/1.xml
  def show
    @examresult = Examresult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examresult }
    end
  end
  
  def show2
    @resultline = Resultline.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examresult }
    end
  end
  
  def examslip
    @resultline = Resultline.find(params[:id])
    render :layout => 'report'
  end
  
  def show_stat
    @examresult = Examresult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examresult }
    end
  end
  
  def show_summary
    @examresult = Examresult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examresult }
    end
  end

  # GET /examresults/new
  # GET /examresults/new.xml
  def new
    @examresult = Examresult.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examresult }
    end
  end
  
  def new_analysis
    
  end

  # GET /examresults/1/edit
  def edit
    @examresult = Examresult.find(params[:id])
  end
  
  def edit_stat
    @examresult = Examresult.find(params[:id])
  end

  # POST /examresults
  # POST /examresults.xml
  def create
    @examresult = Examresult.new(params[:examresult])
    respond_to do |format|
      if @examresult.save
        format.html { redirect_to(@examresult, :notice => 'Examresult was successfully created.') }
        format.xml  { render :xml => @examresult, :status => :created, :location => @examresult }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examresult.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examresults/1
  # PUT /examresults/1.xml
  def update
    @examresult = Examresult.find(params[:id])  
    respond_to do |format|
      if @examresult.update_attributes(params[:examresult])
        format.html { redirect_to(@examresult, :notice => 'Examresult was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examresult.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examresults/1
  # DELETE /examresults/1.xml
  def destroy
    @examresult = Examresult.find(params[:id])
    @examresult.destroy

    respond_to do |format|
      format.html { redirect_to(examresults_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_subject
    @programme_id = params[:programmeid]
    @semester = params[:semester]
    @exammonth2 = params[:exammonth]
    @examyear2 = params[:examyear]
    

    
    unless @programme_id.blank? || @programme_id.nil?
      unless @semester.blank? || @semester.nil?
        unless @examyear2.blank? || @examyear2.nil? || @exammonth2.blank? || @exammonth2.nil?
          @intake = Examresult.set_intake_group(@examyear2,@exammonth2,@semester)
          @subjects = Examresult.get_subjects(@programme_id,@semester)
          #@subjects = Examresult.get_subjects(@programme_id,@intake)
          #@subjects = Examresult.get_subjects(@programme_id,@examyear2,@exammonth2,@intake) 
          @students = Examresult.get_students(@programme_id,@examyear2,@exammonth2,@semester)
        end
      end
    end
    render :partial => 'included_subject', :layout => false   
			 
  end
  
  def view_subject2
    @programme_id = params[:programmeid]
    @semester = params[:semester]
    @exammonth2 = params[:exammonth]
    @examyear2 = params[:examyear]
    
    unless @programme_id.blank? || @programme_id.nil?
      unless @semester.blank? || @semester.nil?
        unless @examyear2.blank? || @examyear2.nil? || @exammonth2.blank? || @exammonth2.nil?
          @subjects = Examresult.get_subjects(@programme_id,@semester)
          @students = Examresult.get_students(@programme_id,@examyear2,@exammonth2,@semester)
        end
      end
    end
    render :partial => 'included_subject2', :layout => false   
			 
  end
   
  def index_stat   #ref: http://stackoverflow.com/questions/5862978/rails-same-model-controller-but-different-view
    @examresults = Examresult.all
    render :partial => 'index_stat', :layout => "layouts/application" #false
  end
  
  def index_summary
    @examresults_intakes = Examresult.all.group_by { |t| t.programme_id } 
    render :partial => 'index_summary', :layout => "layouts/application" 
  end
  
end
