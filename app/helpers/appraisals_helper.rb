module AppraisalsHelper
  
  def add_evactivity_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :evactivities, :partial => 'evactivity', :object => Evactivity.new
    end
  end
  
  def add_straining_link(name)
     link_to_function name do |page|
       page.insert_html :bottom, :strainings, :partial => 'straining', :object => Straining.new
     end
   end
   
   def add_trainneed_link(name)
       link_to_function name do |page|
         page.insert_html :bottom, :trainneeds, :partial => 'trainneed', :object => Trainneed.new
       end
     end
end
