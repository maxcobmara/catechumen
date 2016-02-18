class DocumentsearchesController < ApplicationController
  filter_resource_access
  def new
    @searchdoctype = params[:searchdoctype]
    @documentsearch = Documentsearch.new
  end

  def create
    #raise params.inspect
    @searchdoctype = params[:method]
    if (@searchdoctype == '1' || @searchdoctype == 1)
        @closed = params[:documentsearch][:closed]
        @documentsearch = Documentsearch.new(params[:documentsearch])
      
        if @closed == "Yes"
            @documentsearch.closed = true
        elsif @closed == "No"
            @documentsearch.closed = false
        end
    
        #--letter date---
        @aa=params[:letterdt][:"(1i)"] 
        @bb=params[:letterdt][:"(2i)"]
        @cc=params[:letterdt][:"(3i)"]
        if @aa!='' && @bb!='' && @cc!=''
            @dadidu=@aa+'-'+@bb+'-'+@cc 
        else
            @dadidu=''
        end
        @aa3=params[:letterdtend][:"(1i)"] 
        @bb3=params[:letterdtend][:"(2i)"]
        @cc3=params[:letterdtend][:"(3i)"]
        if @aa3!='' && @bb3!='' && @cc3!=''
            @dadidu3=@aa3+'-'+@bb3+'-'+@cc3 
        else
            @dadidu3=''
        end
        #--letter date---
        #--received date---
        @aa2=params[:letterxdt][:"(1i)"] 
        @bb2=params[:letterxdt][:"(2i)"]
        @cc2=params[:letterxdt][:"(3i)"]
        if @aa2!='' && @bb2!='' && @cc2!=''
            @dadidu2=@aa2+'-'+@bb2+'-'+@cc2 
        else
            @dadidu2=''
        end
        @aa4=params[:letterxdtend][:"(1i)"] 
        @bb4=params[:letterxdtend][:"(2i)"]
        @cc4=params[:letterxdtend][:"(3i)"]
        if @aa4!='' && @bb4!='' && @cc4!=''
            @dadidu4=@aa4+'-'+@bb4+'-'+@cc4 
        else
            @dadidu4=''
        end
        #--received date---
        @documentsearch.letterdt = @dadidu
        if @dadidu3 == ''
            @documentsearch.letterdtend = @dadidu
        else
            @documentsearch.letterdtend = @dadidu3
        end
        @documentsearch.letterxdt = @dadidu2
        if @dadidu4 == ''
            @documentsearch.letterxdtend = @dadidu2
        else
            @documentsearch.letterxdtend = @dadidu4
        end
    end
   
    if @documentsearch.save
      #flash[:notice] = "Successfully created documentsearch."
      redirect_to @documentsearch
    else
      render :action => 'new'
    end
  end

  def show
    @documentsearch = Documentsearch.find(params[:id])
    render :layout => 'report'
  end
end
