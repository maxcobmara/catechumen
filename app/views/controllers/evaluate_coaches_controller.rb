class EvaluateCoachesController < ApplicationController
  # GET /evaluate_coaches
  # GET /evaluate_coaches.xml
  def index
    @evaluate_coaches = EvaluateCoach.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @evaluate_coaches }
    end
  end

  # GET /evaluate_coaches/1
  # GET /evaluate_coaches/1.xml
  def show
    @evaluate_coach = EvaluateCoach.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evaluate_coach }
    end
  end

  # GET /evaluate_coaches/new
  # GET /evaluate_coaches/new.xml
  def new
    @evaluate_coach = EvaluateCoach.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evaluate_coach }
    end
  end

  # GET /evaluate_coaches/1/edit
  def edit
    @evaluate_coach = EvaluateCoach.find(params[:id])
  end

  # POST /evaluate_coaches
  # POST /evaluate_coaches.xml
  def create
    @evaluate_coach = EvaluateCoach.new(params[:evaluate_coach])

    respond_to do |format|
      if @evaluate_coach.save
        flash[:notice] = 'EvaluateCoach was successfully created.'
        format.html { redirect_to(@evaluate_coach) }
        format.xml  { render :xml => @evaluate_coach, :status => :created, :location => @evaluate_coach }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evaluate_coach.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evaluate_coaches/1
  # PUT /evaluate_coaches/1.xml
  def update
    @evaluate_coach = EvaluateCoach.find(params[:id])

    respond_to do |format|
      if @evaluate_coach.update_attributes(params[:evaluate_coach])
        flash[:notice] = 'EvaluateCoach was successfully updated.'
        format.html { redirect_to(@evaluate_coach) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evaluate_coach.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluate_coaches/1
  # DELETE /evaluate_coaches/1.xml
  def destroy
    @evaluate_coach = EvaluateCoach.find(params[:id])
    @evaluate_coach.destroy

    respond_to do |format|
      format.html { redirect_to(evaluate_coaches_url) }
      format.xml  { head :ok }
    end
  end
  
  def penilaijurulatih
     @evaluate_coach = EvaluateCoach.find(params[:id])
     render :layout => 'report'
  end
end
