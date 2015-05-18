class BooksController < ApplicationController
  # GET /books
  # GET /books.xml
  def index
    @books = Book.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.js #1Apr2013
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new
    5.times { @book.accessions.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    #raise params.inspect
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        flash[:notice] = t('book.title2')+" "+t('created')
        format.html { redirect_to(@book) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        flash[:notice] =  t('book.title2')+" "+t('updated')
        format.html { redirect_to(@book) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
  
  def check_availability
    if request.post?
      @isbnsearch = params[:isbn_search].to_s     #doesn't matter what format of data keyed-in
      @isbnsearch2 = @isbnsearch.split('-').to_s
      @result = Book.find_by_isbn(@isbnsearch)
      if !@result && @isbnsearch!= '' 
          @isbn_only = Book.find(:all, :select=> :isbn)
          @isbn_only.each do |x|
            if x.isbn != nil
              aa = x.isbn.split('-').to_s
              if aa == @isbnsearch2
                @result2 = Book.find_by_isbn(x.isbn)
              end
            end
          end
      end
      
      #@result = Book.find(:first, :conditions => ['isbn=? OR isbn=?',@isbnsearch,@isbnsearch2])
      render :layout => false
    end
  end
  
  #2Apr2013-after UAT
  def stock_listing
    if request.post?
      @find_type = params[:list_submit_button]
      if @find_type == t('book.list_by_classno') #"List by class no"
        @class_no = params[:isbn_search].to_s.upcase
        unless @class_no.blank?
          #@book_by_class = Book.find(:all, :conditions => ["classlcc ILIKE ?", "%#{@class_no}%"])  #pg 328 - use this for classlcc containing of string...
          @book_by_class2 = Book.find(:all, :conditions => ["classlcc LIKE ?", "#{@class_no}%"])  #use this for classlcc STARTING WITH.. #http://stackoverflow.com/questions/251345/activerecord-find-starts-with
        else
          @book_by_class2=[]
        end
      elsif @find_type == t('book.list_by_accessionno') #"List by accession no"
        @accs_no = params[:isbn_search].to_s.strip#.upcase   
        @accs_no_end = params[:isbn_search2].to_s.strip
        #@book_by_class = Book.find(:all, :conditions => ["classlcc ILIKE ?", "%#{@class_no}%"])  #pg 328 - use this for classlcc containing of string...
        #temporary - use accessionno in books table (later - TO DO : use accession_no in accessions table)
        #@book_by_class2 = Book.find(:all, :conditions => ["accessionno LIKE ?", "#{@accs_no}%"])  #use this for classlcc STARTING WITH.. #http://stackoverflow.com/questions/251345/activerecord-find-starts-with
        #@book_by_class2 = Book.find(:all, :conditions => {:accessionno => @accs_no..@accs_no_end}, :order => :accession_no) 
        if @accs_no.size==10 && @accs_no_end.size==10
          #@book_ids_in_accessions = Accession.find(:all, :conditions => {:accession_no => '0000001694'..'0000001694'}).map(&:book_id) 
          @book_ids_in_accessions = Accession.find(:all, :conditions => {:accession_no => @accs_no..@accs_no_end}).map(&:book_id) 
          @book_by_class2 = Book.find(:all, :conditions => ['id IN (?)', @book_ids_in_accessions])
          #:row_date => start_date..end_date
        else
          @book_by_class2=[]
        end
      end
    else
       @bb = params[:locals][:class_type]
        if @bb == '1'
          @book_by_class2=Book.all
        end
    end
    render :layout => 'report'  
  end
  #2Apr2013-after UAT
  
  def book_detail
    #raise params.inspect
    @book = Book.find(params[:id])
    @aa = params[:locals][:a]
    render :layout => 'report'
  end

  def stock_verification
    unless request.post?
      ###
      @bb = params[:locals][:class_type]
      @bob = params[:locals][:dodo]
      if @bb == '1'
        #if @bob
        #@books = Book.find(:all, :conditions=>['title =?', 'Abc of otolaryngology-4th edLLLL'])
        @books = Book.search2(@bob)
      #else
        #@books = Book.find(:all, :order => :classlcc) 
      #end
      end
      @books = Book.find(:all, :conditions =>["classlcc LIKE ? OR classlcc LIKE ?", "Q%", "W%"], :order => 'classlcc ASC') if @bb == '2'
      if @bb == '3'
        @books_nlm = Book.find(:all, :conditions =>["classlcc LIKE ? OR classlcc LIKE ?", "Q%", "W%"], :select=>:classlcc).map {|x|x.classlcc}
        @books = Book.find(:all, :conditions => ["classlcc not in (?)", @books_nlm], :order => 'classlcc ASC')
      end
      ###
    else
      @find_type = params[:list_submit_button]
      if @find_type == t('book.list_by_classno2')
        @class_no = params[:isbn_search].to_s.upcase
        unless @class_no.blank?
          @books = Book.find(:all, :conditions => ["classlcc LIKE ?", "#{@class_no}%"], :order => 'classlcc ASC') 
        else
          @books=[]
        end
      elsif @find_type == t('book.list_by_accessionno2')
        @accs_no = params[:isbn_search].to_s.strip#.upcase   
        @accs_no_end = params[:isbn_search2].to_s.strip
        if @accs_no.size==10 && @accs_no_end.size==10
          @book_ids_in_accessions = Accession.find(:all, :conditions => {:accession_no => @accs_no..@accs_no_end}).map(&:book_id) 
          @books = Book.find(:all, :conditions => ['id IN (?)', @book_ids_in_accessions], :order => 'classlcc ASC')
        else
          @books=[]
        end
      end
    end
    render :layout => 'report'
  end
  
end
