class Topicdetail < ActiveRecord::Base
  
  after_save :update_training_notes
  belongs_to :subject_topic, :class_name=>"Programme", :foreign_key => :topic_code
  belongs_to :topic_creator, :class_name=>"Staff", :foreign_key => :prepared_by
  
  has_many :trainingnotes, :dependent => :nullify   #31Oct2013-dependency added
  accepts_nested_attributes_for :trainingnotes, :allow_destroy => true , :reject_if => lambda { |a| a[:title].blank? }
  #:allow_destroy--> what if this newly inserted ...suddenly selected for other lesson_plan.
  
  def update_training_notes
    if topic_code != nil
        @trainingnotes = Trainingnote.find(:all, :conditions=>['topicdetail_id IS NULL AND timetable_id IS NOT NULL']) 
        @trainingnotes.each do |x|
          if WeeklytimetableDetail.find(x.timetable_id).topic == topic_code
            @trainingnote2update = Trainingnote.find(x.id) 
            @trainingnote2update.update_attributes(:topicdetail_id=>id)
          end
        end          
    end
  end
  
  def semester_subject_topic
    if subject_topic.course_type == "Topic"
      "Sem #{subject_topic.parent.parent.code}"+"-"+"#{subject_topic.parent.code}"+" | "+"#{subject_topic.name}"
    elsif subject_topic.course_type == "Subtopic"
      ">>Sem #{subject_topic.parent.parent.parent.code}"+"-"+"#{subject_topic.parent.parent.code}"+" | "+"#{subject_topic.code} "+"#{subject_topic.name}"
    end
  end
  
  def self.search(search)
    if search
      #by subject
      subject_commonsubject = Programme.find(:all, :conditions => ["(name ILIKE(?) or code ILIKE(?)) AND (course_type=? OR course_type=?)","%#{search}%", "%#{search}%", "Subject", "Commonsubject"])
      topic_subtopic_ids = []
      if subject_commonsubject.count > 0
        subject_commonsubject .each do |x|
          topic_subtopic_ids += x.descendants.at_depth(3).map(&:id)
          topic_subtopic_ids += x.descendants.at_depth(4).map(&:id)
        end
      end
      
      #by topic
      topic_subtopic_search = Programme.find(:all, :conditions => ["(name ILIKE(?) or code ILIKE(?)) AND (course_type=? OR course_type=?)","%#{search}%", "%#{search}%", "Topic", "Subtopic"])
      topic_subtopic_ids += topic_subtopic_search.map(&:id) if topic_subtopic_search.count > 0
      
      if topic_subtopic_ids.count > 0
        @topicdetails = Topicdetail.find(:all,:conditions => ["topic_code IN(?)", topic_subtopic_ids], :order => 'updated_at DESC')
      else
        @topicdetails = Topicdetail.find(:all, :order => 'updated_at DESC')
      end
    else   
      @topicdetails = Topicdetail.find(:all, :order => 'updated_at DESC')
    end
    @topicdetails
  end
  
end
