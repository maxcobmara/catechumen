class PersonalizetimetablesearchesController < ApplicationController
  def new
    @searchpersonalizetimetabletype = params[:searchpersonalizetimetabletype]
    @personalizetimetablesearch = Personalizetimetablesearch.new
  end

  def create
    @searchpersonalizetimetabletype = params[:method]
    if @searchpersonalizetimetabletype =='1' || @searchpersonalizetimetabletype == 1
        @personalizetimetablesearch = Personalizetimetablesearch.new(params[:personalizetimetablesearch])
    end 
    if @personalizetimetablesearch.save
      #flash[:notice] = "Successfully created personalizetimetablesearch."
      redirect_to @personalizetimetablesearch
    else
      render :action => 'new'
    end
  end

  def show
    @personalizetimetablesearch = Personalizetimetablesearch.find(params[:id])
  end
end
