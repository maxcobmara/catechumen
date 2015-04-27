class BooksearchesController < ApplicationController
  def new
    @searchbooktype = params[:searchbooktype]
    @booksearch = Booksearch.new
  end

  def create
    #raise params.inspect
    @searchbooktype = params[:method]
    if @searchbooktype == '1' || @searchbooktype == 1
        @booksearch = Booksearch.new(params[:booksearch])
    elsif @searchbooktype == '2' || @searchbooktype == 2
        @booksearch = Booksearch.new(params[:booksearch])
    elsif @searchbooktype == '3' || @searchbooktype == 3
        @booksearch = Booksearch.new(params[:booksearch])
    elsif @searchbooktype == '4' || @searchbooktype == 4
        @booksearch = Booksearch.new(params[:booksearch])
    end 
    if @booksearch.save
      #flash[:notice] = "Successfully created booksearch."
      redirect_to @booksearch
    else
      render :action => 'new'
    end
  end

  def show
    @booksearch = Booksearch.find(params[:id])
  end
end
