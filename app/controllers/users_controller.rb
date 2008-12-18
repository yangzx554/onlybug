class UsersController < ApplicationController
  skip_filter :login_required, :only => [:login,:new,:create]
  def join
    @p = Project.find(params[:project_id])
    @projectUser =  ProjectUser.new({:project_id =>params[:project_id],:user_id =>params[:id]})
    respond_to do |format|
      if @projectUser.save
        flash[:notice] = '加入项目成功'
        format.html { redirect_to(project_users_path(@p))}
      else
        flash.new[:error] = @projectUser.errors
        format.html {redirect_to(project_users_path(@p))}
      end
    end
  end
  def index
    if params[:project_id] && params[:project_id] != nil
    @p = Project.get_cache(params[:project_id])
    @users = @p.users
    @owner = User.get_cache(@p.owner_id)
    else
      @users =User.find(:all)
    end
  end
  def new
    redirect_to "/" if @u != nil
  end
  def profile  
  end
  def logout
    cookies[:auth_token] ={:value =>"" , :expires => Time.now.utc }
    session[:user_id] = nil
    redirect_to "/"
  end
  def edit
  end
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.save! 
    u = User.new
    u.name = params[:user][:name]
    u.password = params[:user][:password]
    u.password_confirmation = params[:user][:password_confirmation]
    u.email = params[:user][:email]
    u.photo_id =@photo.id
    respond_to do |format|
      if u.save
        flash[:notice] = '注册成功'
        format.html { redirect_to(login_path()) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  def login
    @user = User.new
    return unless request.post?
    @user = User.authenticate(params[:email],params[:password])
    if @user
      session[:user_id] = @user.id
      remember_me if params[:remember_me] =="1"
      redirect_to(root_path)
    else
      flash[:error] = "用户名或者密码错误！"
      render :action => "login"
    end
  end
  def show
    @users = User.find(:all)
  end
  protected
  def remember_me
    self.user.remember_me
    cookies[:auth_token] = {
      :value => self.user.login_key,
      :expires => self.user.login_key_expires_at
    }
  end
  private
  def setup_user
  end
end
