class ExamsearchesController < ApplicationController
  def new
    @searchexamtype = params[:searchexamtype]
    @examsearch = Examsearch.new
  end

  def create
    @searchexamtype = params[:method]
    if @searchexamtype == '1' || @searchexamtype == 1
        @examsearch = Examsearch.new(params[:examsearch])
         #--exam date---
          @aa=params[:examdate][:"(1i)"] 
          @bb=params[:examdate][:"(2i)"]
          @cc=params[:examdate][:"(3i)"]
          if @aa!='' && @bb!='' && @cc!=''
              @dadidu=@aa+'-'+@bb+'-'+@cc 
          else
              @dadidu=''
          end
          @examsearch.examdate = @dadidu
          #--exam date---
    end
    if @examsearch.save
      #flash[:notice] = "Successfully created examsearch."
      redirect_to @examsearch
    else
      render :action => 'new'
    end
  end

  def show
    @examsearch = Examsearch.find(params[:id])
  end
end
