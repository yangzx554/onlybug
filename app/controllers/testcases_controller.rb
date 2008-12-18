class TestcasesController < ApplicationController
  def new
    @p = Project.get_cache(params[:project_id])
    @testcase = Testcase.new
  end
  def create
    @p =  Project.get_cache(params[:project_id])
    @testcase = Testcase.new(params[:testcase])
    respond_to do |format|
      @testcase.project_id =@p.id
      @testcase.user_id =@u.id
      if @testcase.save
        Event.create(:user_id =>@u.id,:project_id =>@p.id,:type_id=>@@event_testcase_type,:operate_id =>@@event_operate_create,:content_id=>@testcase.id)
        flash[:notice] ="新建成功"
        format.html {redirect_to  project_testcase_path(@p,@testcase)}
      else
        flash[:error] = @testcase.errors
        format.html{ redirect_to :action =>"new"}
      end
    end
  end
  def show 
    @p = Project.get_cache(params[:project_id])
    @testcase = Testcase.get_cache(params[:id])
    @user = User.get_cache(@testcase.user_id)
    @photo = Photo.get_cache(@user.photo_id)
    @slogs = Seleniumlog.paginate_by_testcase_id(@testcase.id,:order =>"created_at desc" ,:page => params[:page])
  end
  def index
    @p = Project.get_cache(params[:project_id])
    @testcases = @p.testcases
  end
  private 
  def setup_testcase
    @project =Project.find(params[:project_id])
    if params[:id]
      @testcase = Testcase.find(params[:id])
    else
      @testcase = Testcase.new
    end
  end
end
