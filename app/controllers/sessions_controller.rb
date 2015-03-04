# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.erb.html
  def new
  end

  def create
    logout_keeping_session!
    login = Login.authenticate(params[:login], params[:password])
    if login
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_login = login
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = t('session.login_success')
    else
      flash[:notice] = t('session.login_failed')
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = t('session.logout_success')
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = t('session.could_not_log')+"'#{params[:login]}'"
    logger.warn t('session.failed_login_for')+"'#{params[:login]}' "+t('from')+" #{request.remote_ip} "+t('at')+" #{Time.now.utc}"
  end
end
