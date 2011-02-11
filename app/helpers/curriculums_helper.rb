module CurriculumsHelper
  
  def add_doc_link(name)
     link_to_function name do |page|
       page.insert_html :bottom, :docs, :partial => 'doc', :object => Doc.new
     end
   end
  
end
