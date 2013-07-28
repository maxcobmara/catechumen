class ExamanalysissearchesController < ApplicationController
  def new
    @searchexamanalysistype = params[:searchexamanalysistype]
    @examanalysissearch = Examanalysissearch.new
  end

  def create
    @searchexamanalysistype = params[:method]
    if @searchexamanalysistype == '1' || @searchexamanalysistype == 1
        @examanalysissearch = Examanalysissearch.new(params[:examanalysissearch])
        #--exam date---
        @aa=params[:examon][:"(1i)"] 
        @bb=params[:examon][:"(2i)"]
        @cc=params[:examon][:"(3i)"]
        if @aa!='' && @bb!='' && @cc!=''
            @dadidu=@aa+'-'+@bb+'-'+@cc 
        else
            @dadidu=''
        end
        #--exam date---
        @examanalysissearch.examon = @dadidu
    end
    if @examanalysissearch.save
      #flash[:notice] = "Successfully created examanalysissearch."
      redirect_to @examanalysissearch
    else
      render :action => 'new'
    end
  end

  def show
    @examanalysissearch = Examanalysissearch.find(params[:id])
  end
end
