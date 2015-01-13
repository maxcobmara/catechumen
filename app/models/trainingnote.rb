class Trainingnote < ActiveRecord::Base
  
  # befores, relationships, validations, before logic, validation logic, 
   #controller searches, variables, lists, relationship checking
   
  before_save :get_topic_id_from_topicdetail#:get_topic_id_from_timetable
  
  #belongs_to :topic
  #belongs_to :timetable
  belongs_to :note_creator, :class_name => 'Staff', :foreign_key => :staff_id
  belongs_to :topicdetail, :foreign_key=> 'topicdetail_id'
  
  #trial section
  has_many :lesson_plan_trainingnotes , :dependent => :nullify #:destroy # --> once trainingnote in topic details removed, lesson_plan_trainingnote's record will be REMOVED
  has_many :lesson_plans, :through => :lesson_plan_trainingnotes
  #trial section
  has_attached_file :document,
                    :url => "/assets/notes/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/notes/:id/:style/:basename.:extension"
  
  #attr_accessor :topic_id                  
  
  #to retrieve topic id is notes uploaded from lesson_plan
  def get_topic_id_from_timetable
    if topic_id.blank? == true
      self.topic_id = timetable.topic_id
    end
  end
  
  #to retrieve topic id if notes uploaded from topic detail
  def get_topic_id_from_topicdetail
    #if topicdetail_id #!= nil
      timetable_id = 1 #topicdetail_id#Topicdetail.find(topicdetail_id).topic_code
    #end
  end
  
  def subject_topic
    if topicdetail_id!= nil       #view subject code, topic & title of notes
      topic_id = Topicdetail.find(topicdetail_id).topic_code
      if topic_id!=nil   
        topic_list = Programme.at_depth(3).map(&:id)
        subject_list = Programme.at_depth(2).map(&:id)
        subject_id = Programme.find(topic_id).parent.id
        if topic_list.include?(topic_id)==true && subject_list.include?(subject_id)==true
          "#{Programme.find(Topicdetail.find(topicdetail_id).topic_code).parent.code}| #{Programme.find(Topicdetail.find(topicdetail_id).topic_code).name} - #{title}"
        end
      else
        "#{title}"
      end      
    else
      "#{title}"
    end
  end
  
  def self.valid_training_notes
     find(:all, :conditions=>['(topicdetail_id IN(?) or timetable_id IN(?)) or (topicdetail_id is null and timetable_id is null)', Login.current_login.topicdetails_of_programme, Login.current_login.timetables_of_programme])
    #find(:all, :conditions=>['(topicdetail_id IN(?) and timetable_id IN(?)) or (topicdetail_id is null and timetable_id is null)', Login.current_login.topicdetails_of_programme, Login.current_login.timetables_of_programme])
  end
  
  def self.topics_programme
    @position_exist = Login.current_login.staff.position
    if @position_exist     
      @lecturer_programme = @position_exist.unit
      unless @lecturer_programme.nil? 
        @programme = Programme.find(:first, :conditions=>['name ILIKE (?) AND ancestry_depth=?',"%#{@lecturer_programme}%",0])
      end
      unless @programme.nil?
        @programme_id = @programme.id
      else
        if @lecturer_programme != 'Pos Basik' && @position_exist.name=='Pengajar' #== 'Commonsubject' incl (!= Diploma Lanjutan)
          @programme_id = '1'
        else
          @programme_id = '0'
        end
      end
    end 
    if @programme_id == '1' #common_subject
      commonsubject_ids= Programme.find(:all, :conditions=>['course_type=?', "Commonsubject"]).map(&:id)
      topicids_of_commonsubject = []
      for commons_id in commonsubject_ids
        topicids_of_commonsubject +=Programme.find(:all, :conditions=>['id=?', commons_id]).first.descendants.map(&:id)
      end
      @topicids_of_programme =  topicids_of_commonsubject 
    elsif @programme_id =='0' #admin
      @topicids_of_programme = Programme.find(:all, :conditions =>['course_type=? or course_type=?', "Topic", "Subtopic"]).map(&:id)
    else
      @topicids_of_programme = Programme.find(:all, :conditions=>['id=?', @programme_id]).first.descendants.map(&:id)
    end
    
    @topicids_of_programme
  end
  
end
