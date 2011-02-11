module SuppliersHelper
  
  def add_addsupplier_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :addsuppliers, :partial => 'addsupplier', :object => Addsupplier.new
    end
  end
  
  def add_usesupply_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :usesupplies, :partial => 'usesupply', :object => Usesupply.new
    end
  end
  
end
