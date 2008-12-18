class ApplicationController < ActionController::Base
  @@event_project_type = 1
  @@event_page_type = 2
  @@event_testcase_type = 3
  @@event_ticket_type = 4
  @@event_user_type = 5
  @@event_operate_create = 1
  @@event_operate_update = 2
  helper :all
  helper_method :logged_in?
  before_filter  :login_from_cookies ,:login_required,:setup
  after_filter :store_location
  protect_from_forgery :secret => '86035eb951d933a2b7ee72d81d48d642'
  def store_location
    session[:return_to]
  end
  def login_required
    if @u
      return true 
    else
      redirect_to(login_path())
    end
  end
  def login_from_cookies
    return true unless cookies[:auth_token] && !logged_in?
    return true if @u
    user = User.find_by_login_key(cookies[:auth_token])
    if user && user.login_token?
      @u = user
      @u.remember_me
      cookies[:auth_token] = { :value => @u.login_key , :expires => @u.login_key_expires_at  }
      session[:user_id] = @u.id
      flash[:notice] = "登录成功！"
    end
  end
  def logged_in?
 #   puts session[:user_id]
    return nil if session[:user_id].nil?
    return @u unless @u.nil?
 #   self.user = User.find_by_id(session[:user_id])
     self.user = User.get_cache(session[:user_id])
  end
  # Accesses the current user from the session.
  def user
    @u if logged_in?
  end
  def user=(u)
    return if u.nil?
    @u = u
  end
  private 
  def setup
    @projects = Project.get_cache(:all)
  end
end

 