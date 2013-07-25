class WeeklytimetablesearchesController < ApplicationController
  def new
    @searchweeklytimetabletype = params[:searchweeklytimetabletype ]
    @weeklytimetablesearch = Weeklytimetablesearch.new
  end

  def create
    #raise params.inspect
    @searchweeklytimetabletype = params[:method]
    if (@searchweeklytimetabletype  == '1' || @searchweeklytimetabletype == 1)
        @weeklytimetablesearch = Weeklytimetablesearch.new(params[:weeklytimetablesearch])
        #@aa=params[:intake][:"(1i)"] 
        #@bb=params[:intake][:"(2i)"]
        #@cc=params[:intake][:"(3i)"]
        #if @aa!='' && @bb!='' #&& @cc!=''
            #@dadidu=@aa+'-'+@bb+'-'+'01' 
        #else
            #@dadidu=''
        #end
        #@weeklytimetablesearch.intake = @dadidu
        #startdate-----
        @aa2=params[:startdate][:"(1i)"] 
        @bb2=params[:startdate][:"(2i)"]
        @cc2=params[:startdate][:"(3i)"]
        if @aa2!='' && @bb2!=''&& @cc2!=''
            @dadidu2=@aa2+'-'+@bb2+'-'+@cc2
        else
            @dadidu2=''
        end
        @weeklytimetablesearch.startdate = @dadidu2
        #enddate-------
        @aa3=params[:enddate][:"(1i)"] 
        @bb3=params[:enddate][:"(2i)"]
        @cc3=params[:enddate][:"(3i)"]
        if @aa3!='' && @bb3!=''&& @cc3!=''
            @dadidu3=@aa3+'-'+@bb3+'-'+@cc3
        else
            @dadidu3=''
        end
        @weeklytimetablesearch.enddate = @dadidu3
    end
    if @weeklytimetablesearch.save
      #flash[:notice] = "Successfully created weeklytimetablesearch."
      redirect_to @weeklytimetablesearch
    else
      render :action => 'new'
    end
  end

  def show
    @weeklytimetablesearch = Weeklytimetablesearch.find(params[:id])
  end
end
