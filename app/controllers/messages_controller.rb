class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    #@message = Message.new(params[:message])
    @to_names = params[:message][:to_name].gsub(/,\s+/,',')		#sample - "Saadah,Sulijah"
   	@to_name_A = @to_names.split(",") 											#will become - ["Saadah","Sulijah"]
   	@to_id_A = []
   	@to_name_A.each do |to_name|
   		aa = Staff.find_by_name(to_name).id										#result(sample)- ["1","7"]
   		@to_id_A << aa.to_i
   	end

   	@message = Message.new
   	@message.staff_ids = []
   	#@message.staff_ids = ["1","7"] 											#the BEST-correct format for this association
   	@message.staff_ids = @to_id_A 
   	@message.message = params[:message][:message]

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update

    #--27-29 Apr 2012--	
  	@to_names = params[:message][:to_name].gsub(/,\s+/,',')		#sample - "Saadah,Sulijah"
  	@to_name_A = @to_names.split(",") 											#will become - ["Saadah","Sulijah"]
  	@to_id_A = []
  	@to_name_A.each do |to_name|
  		aa = Staff.find_by_name(to_name).id										#result(sample)- ["1","7"]
  		@to_id_A << aa.to_i
  	end

  	@message = Message.find(params[:id])
  	@message.staff_ids = []
  	#@message.staff_ids = ["1","7"] 											#the BEST-correct format for this association
  	@message.staff_ids = @to_id_A 
  	@message.message = params[:message][:message]
    #--27-29 Apr 2012--	
      respond_to do |format|
  	  if @message.update_attributes(:staff_ids => @message.staff_ids, :message => @message.message )	
        #if @message.update_attributes(params[:message])
          flash[:notice] = 'Message was successfully updated.'
          format.html { redirect_to(@message) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
        end
      end
    end
 


  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
