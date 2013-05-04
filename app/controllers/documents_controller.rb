class DocumentsController < ApplicationController
  filter_resource_access
  # GET /documents
  # GET /documents.xml
  def index
    @documents = Document.search(params[:search])
    @document_files = @documents.group_by { |t| t.filedocer }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.xml
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.xml
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end
  
  def action1
     @document = Document.find(params[:id])
  end
   
  def feedback
    @document = Document.find(params[:id])
  end
  
  def download
    @document = Document.find(params[:id])
    send_file @document.data.path, :type => @document.data_content_type
  end
  
 

  # POST /documents
  # POST /documents.xml
  def create
  @document = Document.new(params[:document])
 # @document = Document.new
 # 	@document.staff_ids = []
 #	@document.staff_ids = Document.set_recipient(params[:document][:cc2_staff])			#refer model/message.rb - line 37-49
 #	@document.document = params[:document][:document]
    respond_to do |format|
      if @document.save
        flash[:notice] = 'Document was successfully created.'
        format.html { redirect_to(@document) }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
  # raise params.inspect
    	@document = Document.find(params[:id])
    #  @document.staff_ids = []
    #  @document.staff_ids = Document.set_recipient(params[:document][:cc2_staff])		
    #  @document.cc1date     = Date.civil(params[:document][:"cc1date(1i)"].to_i,params[:document][:"cc1date(2i)"].to_i,params[:document][:"cc1date(3i)"].to_i)
    #  @document.cc1remarks  = params[:document][:cc1remarks]
    #  @document.cc1action   = params[:document][:cc1action]
    #  @document.cc1closed   = params[:document][:cc1closed]
    #  @document.cc2date     = Date.civil(params[:document][:"cc2date(1i)"].to_i,params[:document][:"cc2date(2i)"].to_i,params[:document][:"cc2date(3i)"].to_i)
    #  @document.cc2remarks  = params[:document][:cc2remarks]
    #  @document.cc2action   = params[:document][:cc2action]
    #  @document.cc2closed   = params[:document][:cc2closed]
    respond_to do |format|
    #  if @document.update_attributes(:staff_ids => @document.staff_ids, :cc1date => @document.cc1date, :cc1remarks => @document.cc1remarks, :cc1action => @document.cc1action,
    #     :cc1closed => @document.cc1closed, :cc2date => @document.cc2date, :cc2remarks => @document.cc2remarks, :cc2action => @document.cc2action,
    #        :cc2closed => @document.cc2closed)
     if @document.update_attributes(params[:document])
        flash[:notice] = 'Document was successfully updated.'
        format.html { redirect_to(@document) }
        format.xml  { head :ok }
      else
        format.html { render :action => "action1" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end
  
 

  # DELETE /documents/1
  # DELETE /documents/1.xml
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to(documents_url) }
      format.xml  { head :ok }
    end
  end
end
