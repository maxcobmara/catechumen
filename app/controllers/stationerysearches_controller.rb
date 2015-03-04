class StationerysearchesController < ApplicationController
  def new
    #@searchtype = params[:searchtype]
    @stationerysearch = Stationerysearch.new
  end
  
  def create
    #raise params.inspect
    @stationerysearch = Stationerysearch.new(params[:stationerysearch])
    @stationerysearch.product = params[:stationerysearch][:product]
    @stationerysearch.document = params[:stationerysearch][:document]
    @stationerysearch.issuedby = params[:stationerysearch][:issuedby]
    @stationerysearch.receivedby = params[:stationerysearch][:receivedby]
    
    #--received---
    @aa=params[:received][:"(1i)"] 
    @bb=params[:received][:"(2i)"]
    @cc=params[:received][:"(3i)"]
    if @aa!='' && @bb!='' && @cc!=''
      @dadidu=@aa+'-'+@bb+'-'+@cc  
    else
      @dadidu=''
    end
    @dd=params[:received2][:"(1i)"] 
    @ee=params[:received2][:"(2i)"]
    @ff=params[:received2][:"(3i)"]
    if @dd!='' && @ee!='' && @ff!=''
      @dadidu2=@dd+'-'+@ee+'-'+@ff 
    else
      @dadidu2=''
    end
    @stationerysearch.received = @dadidu
    @stationerysearch.received2 = @dadidu2
    #--received---
    
    #--issuedate---
    @gg=params[:issuedate][:"(1i)"] 
    @hh=params[:issuedate][:"(2i)"]
    @ii=params[:issuedate][:"(3i)"]
    if @gg!='' && @hh!='' && @ii!=''
      @dadidu3=@gg+'-'+@hh+'-'+@ii
    else
      @dadidu3=''
    end
    @jj=params[:issuedate2][:"(1i)"] 
    @kk=params[:issuedate2][:"(2i)"]
    @ll=params[:issuedate2][:"(3i)"]
    if @jj!='' && @kk!='' && @ll!=''
      @dadidu4=@jj+'-'+@kk+'-'+@ll
    else
      @dadidu4=''
    end
    @stationerysearch.issuedate = @dadidu3
    @stationerysearch.issuedate2 = @dadidu4
    #--issudate---
    
    if @stationerysearch.save
      #flash[:notice] = "Successfully created assetsearch."
      redirect_to @stationerysearch
    else
      render :action => 'new'
    end
    
  end  
    
  def show
    #raise params.inspect
    @stationerysearch = Stationerysearch.find(params[:id])
    render :layout => 'report'
  end
  
end
