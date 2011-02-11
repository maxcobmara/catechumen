module PartsHelper
  
  def add_rxpart_link(name)
     link_to_function name do |page|
       page.insert_html :bottom, :rxpart, :partial => 'rxpart', :object =>Rxpart.new
     end
   end
   
  # def add_txsupplies_link(name)
  #     link_to_function name do |page|
   #      page.insert_html :bottom, :txsupplies, :partial => 'txsupplies', :object =>Txsupplies.new
   #    end
   #  end
end
