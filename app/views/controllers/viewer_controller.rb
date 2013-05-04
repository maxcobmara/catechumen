class ViewerController < ApplicationController
  def show
    @page = Page.find_by_name(params[:name])
    @subpages = @page.subpages
    @pagetitle = @page.title
    login_required if @page.admin?
  end

end
