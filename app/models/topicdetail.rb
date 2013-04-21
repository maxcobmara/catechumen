class Topicdetail < ActiveRecord::Base
  
  belongs_to :subject_topic, :class_name=>"Programme", :foreign_key => :topic_code
  belongs_to :topic_creator, :class_name=>"Staff", :foreign_key => :prepared_by
end
