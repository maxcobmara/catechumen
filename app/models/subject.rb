class Subject < ActiveRecord::Base
 
  #Link to HABTM programme_subject
  has_and_belongs_to_many :programmes
  
  #Link to model topics
  has_many :topics, :class_name => 'Topic', :foreign_key => 'subject_id'  
  
  #Link to model exam
  has_many :subject, :class_name => 'Examquestion', :foreign_key => 'curriculum_id' 
  
  #Link to model courseevaluation
  has_many :subjectevaluate, :class_name => 'Courseevaluation', :foreign_key => 'subject_id'
  
  #Link to model timetableentry
  has_many :subjecttotime, :class_name => 'Time_table_entry', :foreign_key => 'subject_id'
  
  #Link to Model Grade
  has_many :subjectgrade,  :class_name => 'Grade', :foreign_key => 'subject_id'
  
  
  def subject_code_with_subject_name
     "#{subjectcode}  #{name}"
   end
  
  
  
  # code for repeating field qualification
    has_many :topics, :dependent => :destroy

    def new_topic_attributes=(topic_attributes)
      topic_attributes.each do |attributes|
        topics.build(attributes)
      end
    end

    after_update :save_topics

    def existing_topic_attributes=(topic_attributes)
      topics.reject(&:new_record?).each do |topic|
        attributes = topic_attributes[topic.id.to_s]
        if attributes
          topic.attributes = attributes
        else
          topics.delete(topic)
        end
      end
    end

    def save_topics
      topics.each do |topic|
        topic.save(false)
      end
    end
    
STATUS = [
            #  Displayed       stored in db
            [ "Major","1" ],
            [ "Minor","2" ],
            [ "Elective","3" ]
            
]

    
     
end
