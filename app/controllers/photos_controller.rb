class PhotosController < ApplicationController
  filter_resource_access
  def index
    @photos=Photo.find(:all, :order => "caption ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
      format.js
    end
  end
  
  def new
    @photo=Photo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examquestion }
    end
  end
  
  def create
    @photo=Photo.new(params[:photo])
     respond_to do |format|
      if @photo.save
        format.html { redirect_to(@photo, :notice =>  (t 'photo.title')+" "+(t 'created')) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end  
  end
  
  def show
    @photo=Photo.find(params[:id])
  end
  
  def edit
    @photo=Photo.find(params[:id])
  end
  
  def update
    @photo=Photo.find(params[:id])
     respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to(@photo, :notice =>  (t 'photo.title')+" "+(t 'updated')) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end  
  end
  
  def destroy
    @photo=Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
  
  
end