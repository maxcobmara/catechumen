module SubjectsHelper
  
  def add_topic_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :topics, :partial => 'topic', :object => Topic.new
    end
  end
  
end
