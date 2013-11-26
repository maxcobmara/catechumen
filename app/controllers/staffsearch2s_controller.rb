class Staffsearch2sController < ApplicationController
  def new
    @staffsearch2 = Staffsearch2.new
  end

  def create
    #raise params.inspect
    @staffsearch2 = Staffsearch2.new(params[:staffsearch2])
    if @staffsearch2.save
      #flash[:notice] = "Successfully created staffsearch2."
      redirect_to @staffsearch2
    else
      render :action => 'new'
    end
  end

  def show
    @staffsearch2 = Staffsearch2.find(params[:id])
    render :layout => 'report'
  end
end
