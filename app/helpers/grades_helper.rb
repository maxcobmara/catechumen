module GradesHelper
  
  
  def add_score_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :scores, :partial => 'score', :object => Score.new
    end
  end
end
