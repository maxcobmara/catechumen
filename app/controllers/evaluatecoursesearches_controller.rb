class EvaluatecoursesearchesController < ApplicationController
  def new
    @searchevaluatecoursetype = params[:searchevaluatecoursetype]
    @evaluatecoursesearch = Evaluatecoursesearch.new
  end

  def create
    @searchevaluatecoursetype = params[:method]
    if @searchevaluatecoursetype=='1' || @searchevaluatecoursetype == 1
        @evaluatecoursesearch = Evaluatecoursesearch.new(params[:evaluatecoursesearch])
        #--evaluation date---
        @aa=params[:evaldate][:"(1i)"] 
        @bb=params[:evaldate][:"(2i)"]
        @cc=params[:evaldate][:"(3i)"]
        if @aa!='' && @bb!='' && @cc!=''
            @dadidu=@aa+'-'+@bb+'-'+@cc 
        else
            @dadidu=''
        end
        #--evaluation date---
        @evaluatecoursesearch.evaldate = @dadidu
    end
    if @evaluatecoursesearch.save
      #flash[:notice] = "Successfully created evaluatecoursesearch."
      redirect_to @evaluatecoursesearch
    else
      render :action => 'new'
    end
  end

  def show
    @evaluatecoursesearch = Evaluatecoursesearch.find(params[:id])
  end
end
