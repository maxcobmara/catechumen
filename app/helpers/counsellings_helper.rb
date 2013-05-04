module CounsellingsHelper
  
  def add_scsession_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :scsessions, :partial => 'scsession', :object => Scsession.new
    end
  end
end
