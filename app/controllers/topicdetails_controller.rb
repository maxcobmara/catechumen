class TopicdetailsController < ApplicationController
  filter_resource_access
  # GET /topicdetails
  # GET /topicdetails.xml
  def index
    @position_exist = Login.current_login.staff.position
    if @position_exist 
      @topicdetails = Topicdetail.search(params[:search])#find(:all, :order => 'updated_at DESC')
      #@topicdetails = Topicdetail.all            #use this semula #before30Oct2013
      #@topicdetails = Topicdetail.find(:all,:conditions=>['topic_code IS NOT NULL'])    #31Oct2013
      @topicdetails2 = Topicdetail.find(:all,:conditions=>['topic_code IS NULL'])    #31Oct2013
    end
    respond_to do |format|
      if @position_exist
        format.html # index.html.erb
        format.xml  { render :xml => @topicdetails }
      else
        format.html { redirect_to "/home", :notice =>t('position_required')+t('topicdetail.title2')}
        format.xml
      end
    end
  end

  # GET /topicdetails/1
  # GET /topicdetails/1.xml
  def show
    @topicdetail = Topicdetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topicdetail }
    end
  end

  # GET /topicdetails/new
  # GET /topicdetails/new.xml
  def new
    @job_type = params[:job_type]
    @rec_select = params[:rec_select]
    @topicdetail = Topicdetail.new
    @lecturer_programme = current_login.staff.position.unit
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_id = @programme.id 
      @topic_programme = Programme.find(@programme_id).descendants.at_depth(3).map(&:id)
      @subtopic_programme = Programme.find(@programme_id).descendants.at_depth(4).map(&:id)
      @topic_subtopic = @topic_programme + @subtopic_programme
      @semester_subject_topic_list = Programme.find(:all,:conditions=>['id IN(?) AND id NOT IN(?)',@topic_subtopic, Topicdetail.all.map(&:topic_code).compact.uniq], :order=>:combo_code)
    else
      @semester_subject_topic_list = Programme.find(:all,:conditions=>['ancestry_depth=? OR ancestry_depth=?',3,4], :order=>:combo_code)
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topicdetail }
    end
  end

  # GET /topicdetails/1/edit
  def edit
    @topicdetail = Topicdetail.find(params[:id])
    @lecturer_programme = current_login.staff.position.unit
    unless @lecturer_programme.nil?
      @programme = Programme.find(:first,:conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
    end
    unless @programme.nil?
      @programme_id = @programme.id 
      @topic_programme = Programme.find(@programme_id).descendants.at_depth(3)
      @subtopic_programme = Programme.find(@programme_id).descendants.at_depth(4)
      @topic_subtopic = @topic_programme + @subtopic_programme
      @semester_subject_topic_list = Programme.find(:all,:conditions=>['id IN(?) AND id NOT IN(?)',@topic_subtopic, Topicdetail.all.map(&:topic_code).compact.uniq], :order=>:combo_code)
    else
      @semester_subject_topic_list = Programme.find(:all,:conditions=>['ancestry_depth=? OR ancestry_depth=?',3,4], :order=>:combo_code)
    end
  end

  # POST /topicdetails
  # POST /topicdetails.xml
  def create
    @topicdetail = Topicdetail.new(params[:topicdetail])

    respond_to do |format|
      if @topicdetail.save
        format.html { redirect_to(@topicdetail, :notice =>  t('topicdetail.title2')+" "+t('created')) }
        format.xml  { render :xml => @topicdetail, :status => :created, :location => @topicdetail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topicdetail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topicdetails/1
  # PUT /topicdetails/1.xml
  def update
    @topicdetail = Topicdetail.find(params[:id])

    respond_to do |format|
      if @topicdetail.update_attributes(params[:topicdetail])
        format.html { redirect_to(@topicdetail, :notice =>  t('topicdetail.title2')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topicdetail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topicdetails/1
  # DELETE /topicdetails/1.xml
  def destroy
    @topicdetail = Topicdetail.find(params[:id])
    @topicdetail.destroy

    respond_to do |format|
      format.html { redirect_to(topicdetails_url) }
      format.xml  { head :ok }
    end
  end
end
