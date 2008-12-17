class ProjectsController < ApplicationController
  def index
    @projects = Project.find(:all)
  end
  def new
  end
  def create
    @p = Project.new(params[:project])
    @p.owner_id = @u.id
    respond_to do |format|
      if @p.save
        ProjectUser.create({:user_id => @u.id ,:project_id => @p.id})
        Page.create(:project_id =>@p.id,:user_id =>@u.id,:title=>@p.name,:content=>"hello")
        Event.create({:project_id=>@p.id,:user_id =>@u.id,:type_id =>2,:content_id => @p.id,:operate_id=>1})
        format.html { redirect_to(@p) }
      else
        flash.now[:error] = @p.error
        format.html { render :action => "new" }
      end
    end
  end
  def update
    @p = Project.find(params[:id])
    respond_to do |format|
      if @p.update_attributes params[:project]
        flash[:notice]= " 项目修改成功"
        format.html { redirect_to(@p)}
      else
        flash.now[:error] = @p.errors
        format.html { render :action => "edit"}
      end
    end
  end
  def show
    #   @p =Project.find(params[:id])
    @p = Project.get_cache(params[:id])
    @events = Event.find_all_by_project_id(@p.id ,:order =>"created_at Desc")
  end
  def edit
    @p = Project.find(params[:id])
  end
end
