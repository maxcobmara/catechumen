module AssetsHelper
  
  def add_assetnum_link(name)
     link_to_function name do |page|
       page.insert_html :bottom, :assetnums, :partial => 'assetnum', :object => Assetnum.new
     end
   end
   
   def add_maint_link(name)
        link_to_function name do |page|
          page.insert_html :bottom, :maints, :partial => 'maint', :object => Maint.new
        end
      end

end
