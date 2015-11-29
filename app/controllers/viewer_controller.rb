class ViewerController < ApplicationController
  def show
    @page = Page.find_by_name(params[:name])
    @subpages = @page.subpages
    @pagetitle = @page.title
    login_required if @page.admin?
  end
  
  def equeryreports
    unless params[:query_module].blank?
      @query_module=params[:query_module]
    end
  end
  
  def librarystats
  end
  
  def library_rules
  end

end
