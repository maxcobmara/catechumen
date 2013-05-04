module ResidencesHelper
  
  def add_asset_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :assets, :partial => 'asset', :object => Asset.new
    end
  end
end
