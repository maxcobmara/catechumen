class Topicdetail < ActiveRecord::Base
  
  belongs_to :subject_topic, :class_name=>"Programme", :foreign_key => :topic_code
  belongs_to :topic_creator, :class_name=>"Staff", :foreign_key => :prepared_by
  
  has_many :trainingnotes, :dependent => :destroy
  accepts_nested_attributes_for :trainingnotes, :reject_if => lambda { |a| a[:title].blank? }
  
end
