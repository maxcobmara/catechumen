class PhotosController < ApplicationController
  
  def index
    @photos=photo.find(:all, :order => "caption ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
      format.js
    end
  end
  
  def new
    @photo=photo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examquestion }
    end
  end
  
  def create
    @photo=photo.new(params[:photo])
     respond_to do |format|
      if @photo.save
        flash[:notice] = t('examquestion.title2')+" "+t('created')
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end  
  end
  
  def edit
    @photo=photo.find(params[:id])
  end
  
  def show
    @photo=photo.find(params[:id])
  end
  
end