class TrainingNotesController < ApplicationController
  # GET /training_notes
  # GET /training_notes.xml
  def index
    @training_notes = TrainingNote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @training_notes }
    end
  end

  # GET /training_notes/1
  # GET /training_notes/1.xml
  def show
    @training_note = TrainingNote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @training_note }
    end
  end

  # GET /training_notes/new
  # GET /training_notes/new.xml
  def new
    @training_note = TrainingNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @training_note }
    end
  end

  # GET /training_notes/1/edit
  def edit
    @training_note = TrainingNote.find(params[:id])
  end

  # POST /training_notes
  # POST /training_notes.xml
  def create
    @training_note = TrainingNote.new(params[:training_note])

    respond_to do |format|
      if @training_note.save
        flash[:notice] = 'TrainingNote was successfully created.'
        format.html { redirect_to(@training_note) }
        format.xml  { render :xml => @training_note, :status => :created, :location => @training_note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @training_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /training_notes/1
  # PUT /training_notes/1.xml
  def update
    @training_note = TrainingNote.find(params[:id])

    respond_to do |format|
      if @training_note.update_attributes(params[:training_note])
        flash[:notice] = 'TrainingNote was successfully updated.'
        format.html { redirect_to(@training_note) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @training_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /training_notes/1
  # DELETE /training_notes/1.xml
  def destroy
    @training_note = TrainingNote.find(params[:id])
    @training_note.destroy

    respond_to do |format|
      format.html { redirect_to(training_notes_url) }
      format.xml  { head :ok }
    end
  end
end
