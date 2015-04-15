class PersonalizetimetablesearchesController < ApplicationController
  def new
    @searchpersonalizetimetabletype = params[:searchpersonalizetimetabletype]
    @personalizetimetablesearch = Personalizetimetablesearch.new
    @valid_intakes = Weeklytimetable.validintake_timetable
  end

  def create
    @searchpersonalizetimetabletype = params[:method]
    if @searchpersonalizetimetabletype =='1' || @searchpersonalizetimetabletype == 1
        @personalizetimetablesearch = Personalizetimetablesearch.new(params[:personalizetimetablesearch])
    end 
    startdate = Weeklytimetable.all.sort_by{|y|y.startdate}.first.startdate
    enddate = Weeklytimetable.all.sort_by{|y|y.startdate}.last.startdate
    if @personalizetimetablesearch.enddate && @personalizetimetablesearch.enddate < startdate #required or error will arise
      @personalizetimetablesearch.enddate=enddate 
      @wrongenddate='1'
    else
      @wrongenddate='0'
    end
    if @personalizetimetablesearch.startdate && @personalizetimetablesearch.startdate < startdate #required for logical purpose
      @personalizetimetablesearch.startdate=startdate 
      @wrongstartdate='1'
    else
      @wrongdstartdate='0'
    end 
    if @personalizetimetablesearch.save
      #flash[:notice] = "Successfully created personalizetimetablesearch."
      redirect_to personalizetimetablesearch_path(@personalizetimetablesearch,  :x =>@wrongenddate, :y => @wrongstartdate)
    else
      render :action => 'new'
    end
  end

  def show
    @personalizetimetablesearch = Personalizetimetablesearch.find(params[:id])
    @wrongenddate = params[:x]
    @wrongstartdate = params[:y]
  end
end
