class LibrarytransactionsearchesController < ApplicationController
  def new
    @searchlibrarytransactiontype = params[:searchlibrarytransactiontype]
    @librarytransactionsearch = Librarytransactionsearch.new
  end

  def create
    #raise params.inspect
    @searchlibrarytransactiontype = params[:method]
    if @searchlibrarytransactiontype == '1' || @searchlibrarytransactiontype == 1
        @librarytransactionsearch = Librarytransactionsearch.new(params[:librarytransactionsearch])
        #--yearstat---
        @aa=params[:yearstat][:"(1i)"] 
        @bb=params[:yearstat][:"(2i)"]
        @cc=params[:yearstat][:"(3i)"]
        if @aa!=''    #&& @bb!='' && @cc!=''
            @dadidu=@aa+'-'+'01'+'-'+'01'        #@bb+'-'+@cc  
        else
            @dadidu=''
        end
        @librarytransactionsearch.yearstat = @dadidu
        #--yearstat---
    end 
    if @librarytransactionsearch.save
      #flash[:notice] = "Successfully created librarytransactionsearch."
      redirect_to @librarytransactionsearch
    else
      render :action => 'new'
    end
  end

  def show
    @librarytransactionsearch = Librarytransactionsearch.find(params[:id])
  end
end
