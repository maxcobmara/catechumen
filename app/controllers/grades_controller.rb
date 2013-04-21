class GradesController < ApplicationController
  # GET /grades
  # GET /grades.xml
  def index
    @grades = Grade.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grades }
    end
  end

  # GET /grades/1
  # GET /grades/1.xml
  def show
    @grade = Grade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grade }
    end
  end

  # GET /grades/new
  # GET /grades/new.xml
  def new
    @new_type = params[:new_type]                                                       # retrieve - parameter sent via link_to
	  if @new_type && @new_type == "1"                                                    # multiple new records
		  @grades = Array.new(1) { Grade.new } 	#(params[:grades])
		  @grades.each do |grade|                                                           # have to build nested attribute, score(formative) inside of each item of grade array
		    grade.scores.build
      end
    elsif @new_type && @new_type =="0"                                                  # one new record
	    @grade = Grade.new(params[:grade]) 
	    @grade.scores.build
	  end  
    
    #@grade = Grade.new
    #@grade.scores.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grade }
    end
  end

  # GET /grades/1/edit
  def edit
    @grade = Grade.find(params[:id])
  end

  # POST /grades
  # POST /grades.xml
  def create
    @grade = Grade.new(params[:grade]) 
    @new_type ="0"                                                            # Assign same value as defined value in new action (:new_type value for 'New grade' link in index page!)
    
    @grades_all = params[:grades]     
    
    respond_to do |format|
        if @grade.save
          flash[:notice] = 'Grade was successfully created.'
          format.html { redirect_to(@grade) }
          format.xml  { render :xml => @grade, :status => :created, :location => @grade }
        else
          format.html { render :new }                                      
          format.xml  { render :xml => @grade.errors, :status => :unprocessable_entity }
        end
    end   # end of respond_to do block
  end

  # PUT /grades/1
  # PUT /grades/1.xml
  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        flash[:notice] = 'Grade was successfully updated.'
        format.html { redirect_to(@grade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.xml
  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy

    respond_to do |format|
      format.html { redirect_to(grades_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_subject
    @programme_id = params[:programmeid]
    unless @programme_id.blank? 
      #@subjects = Subject.find(:all, :joins => :programmes,:conditions => ['programme_id=?', @programme_id])
      @subjects = Programme.find(@programme_id).descendants.at_depth(2)
    end
    render :partial => 'view_subject', :layout => false
  end
  
end
