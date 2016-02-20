class LoginsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  filter_resource_access
   
  #before_filter :login_required   #for NEW(SIGNUP) - MUST LOGIN ???
  before_filter :login_required, :except => [:new, :create]  
  
  
  def index
    #@logins = Login.find(:all)
    @filters = Login::FILTERS
      if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
        @logins = Login.with_permissions_to(:index).send(params[:show]) #unhide - 15July2013
        #@logins = Login.send(params[:show])                            #hide - 15July2013
      else
        #@logins = Login.with_permissions_to(:index).relevant           
        @logins = Login.find(:all)                                     
    end
     
   end

   def show
     @login = Login.find(params[:id])
   end

   def destroy
     @login = Login.find(params[:id])
     @login.destroy

     redirect_to(logins_url)
   end

   def edit
     @login = Login.find(params[:id])
   end

   def update
     @login = Login.find(params[:id])

     if @login.update_attributes(params[:login])
       flash[:notice] = t('login.account')+" "+t('updated')
       #redirect_to(login_path(@login))
       render :action => 'show'
       flash.discard
     else
       render :action => 'edit'
     end
   end
  

  # render new.rhtml
  def new
    @login = Login.new
  end
 
  def create
    logout_keeping_session!
    @login = Login.new(params[:login])
    success = @login && @login.save
    if success && @login.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_login = @login # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = t('login.registered')
    else
      #flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      flash[:error]  = t('login.registration_failed')
      render :action => 'new'
    end
  end
end
