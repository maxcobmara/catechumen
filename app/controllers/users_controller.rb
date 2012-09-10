class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  
   
  #before_filter :login_required
  
  
  
  def index
    #@users = User.find(:all)
    @filters = User::FILTERS
      if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
        #@users = User.with_permissions_to(:index).send(params[:show])
        @users = User.send(params[:show])
      else
        #@users = User.with_permissions_to(:index).relevant
        @users = User.find(:all)
    end
     
   end

   def show
     @user = User.find(params[:id])
   end

   def destroy
     @user = User.find(params[:id])
     @user.destroy

     redirect_to(users_url)
   end

   def edit
     @user = User.find(params[:id])
   end

   def update
     @user = User.find(params[:id])

     if @user.update_attributes(params[:user])
       flash[:notice] = 'User was successfully updated.'
       redirect_to(user_path(@user))
     else
       render :action => 'edit'
     end
   end
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  The IT team will process your application as soon as possible"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
end
