class AddressBookItemsController < ApplicationController
  # GET /address_book_items
  # GET /address_book_items.xml
  def index
    @address_book_items = AddressBookItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @address_book_items }
    end
  end

  # GET /address_book_items/1
  # GET /address_book_items/1.xml
  def show
    @address_book_item = AddressBookItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address_book_item }
    end
  end

  # GET /address_book_items/new
  # GET /address_book_items/new.xml
  def new
    @address_book_item = AddressBookItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address_book_item }
    end
  end

  # GET /address_book_items/1/edit
  def edit
    @address_book_item = AddressBookItem.find(params[:id])
  end

  # POST /address_book_items
  # POST /address_book_items.xml
  def create
    @address_book_item = AddressBookItem.new(params[:address_book_item])

    respond_to do |format|
      if @address_book_item.save
        format.html { redirect_to(@address_book_item, :notice => 'AddressBookItem was successfully created.') }
        format.xml  { render :xml => @address_book_item, :status => :created, :location => @address_book_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @address_book_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /address_book_items/1
  # PUT /address_book_items/1.xml
  def update
    @address_book_item = AddressBookItem.find(params[:id])

    respond_to do |format|
      if @address_book_item.update_attributes(params[:address_book_item])
        format.html { redirect_to(@address_book_item, :notice => 'AddressBookItem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @address_book_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /address_book_items/1
  # DELETE /address_book_items/1.xml
  def destroy
    @address_book_item = AddressBookItem.find(params[:id])
    @address_book_item.destroy

    respond_to do |format|
      format.html { redirect_to(address_book_items_url) }
      format.xml  { head :ok }
    end
  end
end
