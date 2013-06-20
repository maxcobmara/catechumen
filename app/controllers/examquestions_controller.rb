class ExamquestionsController < ApplicationController
  # GET /examquestions
  # GET /examquestions.xml
  def index
     #-----in case-use these 4 lines-------
      @programmes = Programme.roots
      #@examquestions = Examquestion.search2(params[:programmid])    #all if not specified
      #@subject_exams = @examquestions.group_by { |t| t.subject_details }
      #@topic_exams = @examquestions.group_by { |t| t.topic_id }
      #-----in case-use these 4 lines-------

      @aaaaa=params[:subjectselect]
      submit_val = params[:submit_button1]
      if (params[:subjectselect] =='0' || params[:subjectselect] ==0) && submit_val == "Search"
          @examquestions = Examquestion.search2(params[:programmid])    #all if not specified
      elsif (params[:subjectselect] !='' || params[:subjectselect] !=nil) && submit_val == "Search"
          @examquestions = Examquestion.find(:all, :conditions=>['subject_id=?',@aaaaa])
      elsif !submit_val
          @examquestions = Examquestion.search2(params[:programmid])    #all if not specified
      end 
      @subject_exams = @examquestions.group_by { |t| t.subject_details }    
      @topic_exams = @examquestions.group_by { |t| t.topic_id } 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examquestions }
      format.xls {send_data @examquestions.to_xls(:name=>"Exam Questions",:headers => Examquestion.header_excel, 
  		:columns => Examquestion.column_excel ), :file_name => 'examquestions.xls' }
  		#----start of-same result as line 10-11----------------------------------------------------------
  		#format.xls {send_data @examquestions.to_xls(:name=>"Exam Questions",:headers => ["Subject Code","Subject Name","Question Type","Marks","Category","Difficulty","Question","Answer", "Status","Creator Name"], 
  		#:columns => [{:subject => [:subjectcode, :name]}, :questiontype, :marks, :category,{:examQ=>[:difficultyname]},:question, :answer, :qstatus,{:creator=> [:staff_name_with_position] }] ), :file_name => 'examquestions.xls' }
  		#----end of-same result as line 10-11------------------------------------------------------------
  		
      #--start--alternative solution no.1--------------------------------------------
  		##without usage of any gem or plugin (don't forget to set mime_types as well)
      ##file type generated will be in HTML (excel user friendly)
      #format.xls   #will generate excel file from index.xls.erb 
      #--end--alternative solution no.1----------------------------------------------

      #--start--alternative solution no.2 (part 1)-----------------------------------
      ##to be used with view/examquestion/export.html.erb 
      ##to activate - unremark line 113/116, routes.rb 
      ##to add link_to in index page - view/examquestion/export.html.erb  
      #--end--alternative solution no.2 (part 1)------------------------------------- 
      
      #----start of----PDF creation of examquestions-15 May 2012 --------------------
      #--1) set -> mime-type : initializer/mimes_types.rb
      #--2) include -> require 'pdf/writer', require 'pdf/simpletable' : lib/examquestion_drawer.rb
      #--3) include -> link for pdf format : view/examquestions/index.html.erb
      #--4) include format.pdf block as below...
      format.pdf do
 			  send_data ExamquestionDrawer.draw(@examquestions),:filename => 'examquestion.pdf', :type=>'application/pdf',:disposition=>'inline'
 		  end
 		  #----end of----PDF creation of examquestions-15 May 2012 ----------------------
 		  
    end   #--end for---respond_to do
  end     #--end for---def index

  #--start--alternative solution no.2 (part 2)---------------------------------------
    #def export 
  	#@examquestions = Examquestion.find(:all)
      #headers['Content-Type'] = "application/vnd.ms-excel"
      #headers['Content-Disposition'] = 'attachment; filename="report.xls"'
      #headers['Cache-Control'] = ''
    #end
  #--end--alternative solution no.2 (part 2)-----------------------------------------
    
  # GET /examquestions/1
  # GET /examquestions/1.xml
  def show
    @examquestion = Examquestion.find(params[:id])
    @q_frequency=Examquestion.find(:all, :joins=>:exams,:conditions=>['examquestion_id=?',(params[:id])])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examquestion }

    end
  end

  # GET /examquestions/new
  # GET /examquestions/new.xml
  def new
    @examquestion = Examquestion.new
    #@examquestion.exammcqanswers.build
    #@examquestion.examsubquestions.build
    3.times { @examquestion.shortessays.build }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examquestion }
    end
  end

  # GET /examquestions/1/edit
  def edit
    @examquestion = Examquestion.find(params[:id])
  end

  # POST /examquestions
  # POST /examquestions.xml
  def create
    @examquestion = Examquestion.new(params[:examquestion])

    respond_to do |format|
      if @examquestion.save
        flash[:notice] = 'Examquestion was successfully created.'
        format.html { redirect_to(@examquestion) }
        format.xml  { render :xml => @examquestion, :status => :created, :location => @examquestion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examquestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examquestions/1
  # PUT /examquestions/1.xml
  def update
    @examquestion = Examquestion.find(params[:id])

    respond_to do |format|
      if @examquestion.update_attributes(params[:examquestion])
        flash[:notice] = 'Examquestion was successfully updated.'
        format.html { redirect_to(@examquestion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examquestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examquestions/1
  # DELETE /examquestions/1.xml
  def destroy
    @examquestion = Examquestion.find(params[:id])
    @examquestion.destroy

    respond_to do |format|
      format.html { redirect_to(examquestions_url) }
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
  
  def view_topic
    @subject_id = params[:subjectid]
    unless @subject_id.blank? 
      @topics = Programme.find(@subject_id).descendants.at_depth(3)
    end
    render :partial => 'view_topic', :layout => false
  end
  

end
