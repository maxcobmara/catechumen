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
  
end
