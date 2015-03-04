class TrainingnotesController < ApplicationController
  filter_resource_access
  # GET /trainingnotes
  # GET /trainingnotes.xml
  def index
    @position_exist = Login.current_login.staff.position
    if @position_exist     
      #@trainingnotes = Trainingnote.with_permissions_to(:edit).find(:all, :order => 'topicdetail_id')#:order => 'topic_id')
      @trainingnotes = Trainingnote.with_permissions_to(:edit).search(params[:search])
    end
    respond_to do |format|
      if @position_exist
        format.html # index.html.erb
        format.xml  { render :xml => @trainingnotes }
      else
        format.html { redirect_to "/home", :notice =>t('position_required')+t('training_note.title')}
        format.xml
      end
    end
  end

  # GET /trainingnotes/1
  # GET /trainingnotes/1.xml
  def show
    @trainingnote = Trainingnote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trainingnote }
    end
  end

  # GET /trainingnotes/new
  # GET /trainingnotes/new.xml
  def new
    @trainingnote = Trainingnote.new
    @semester_subject_topic_list_bytopicdetail = Topicdetail.find(:all, :joins=>:subject_topic, :conditions=>[' topic_code IN(?)  AND (course_type=? OR course_type=?)',Trainingnote.topics_programme, "Topic", "Subtopic"]).sort_by{|x| x.subject_topic.combo_code}
    login_w_adminrole = Login.find(:all, :joins=>:roles, :conditions => ['roles.id=?',2]).map(&:id) 
    @staff_w_adminrole= Login.find(:all, :conditions=>['id IN(?)',login_w_adminrole]).map(&:staff_id)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trainingnote }
    end
  end

  # GET /trainingnotes/1/edit
  def edit
    @trainingnote = Trainingnote.find(params[:id])
    @semester_subject_topic_list_bytopicdetail = Topicdetail.find(:all, :joins=>:subject_topic, :conditions=>[' topic_code IN(?)  AND (course_type=? OR course_type=?)',Trainingnote.topics_programme, "Topic", "Subtopic"]).sort_by{|x| x.subject_topic.combo_code}
    login_w_adminrole = Login.find(:all, :joins=>:roles, :conditions => ['roles.id=?',2]).map(&:id) 
    @staff_w_adminrole= Login.find(:all, :conditions=>['id IN(?)',login_w_adminrole]).map(&:staff_id)
  end

  # POST /trainingnotes
  # POST /trainingnotes.xml
  def create
    @trainingnote = Trainingnote.new(params[:trainingnote])
    
    #in case validation failed
    @semester_subject_topic_list_bytopicdetail = Topicdetail.find(:all, :joins=>:subject_topic, :conditions=>[' topic_code IN(?)  AND (course_type=? OR course_type=?)',Trainingnote.topics_programme, "Topic", "Subtopic"]).sort_by{|x| x.subject_topic.combo_code}
    login_w_adminrole = Login.find(:all, :joins=>:roles, :conditions => ['roles.id=?',2]).map(&:id) 
    @staff_w_adminrole= Login.find(:all, :conditions=>['id IN(?)',login_w_adminrole]).map(&:staff_id)
    
    respond_to do |format|
      if @trainingnote.save
        flash[:notice] = t('training_note.title')+" "+t('created')
        format.html { redirect_to(@trainingnote) }
        format.xml  { render :xml => @trainingnote, :status => :created, :location => @trainingnote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trainingnote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trainingnotes/1
  # PUT /trainingnotes/1.xml
  def update
    @trainingnote = Trainingnote.find(params[:id])
    
    #in case validation failed
    @semester_subject_topic_list_bytopicdetail = Topicdetail.find(:all, :joins=>:subject_topic, :conditions=>[' topic_code IN(?)  AND (course_type=? OR course_type=?)',Trainingnote.topics_programme, "Topic", "Subtopic"]).sort_by{|x| x.subject_topic.combo_code}
    login_w_adminrole = Login.find(:all, :joins=>:roles, :conditions => ['roles.id=?',2]).map(&:id) 
    @staff_w_adminrole= Login.find(:all, :conditions=>['id IN(?)',login_w_adminrole]).map(&:staff_id)
    
    respond_to do |format|
      if @trainingnote.update_attributes(params[:trainingnote])
        flash[:notice] = t('training_note.title')+" "+t('updated')
        format.html { redirect_to(@trainingnote) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trainingnote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trainingnotes/1
  # DELETE /trainingnotes/1.xml
  def destroy
    @trainingnote = Trainingnote.find(params[:id])
    @trainingnote.destroy

    respond_to do |format|
      format.html { redirect_to(trainingnotes_url) }
      format.xml  { head :ok }
    end
  end
end
