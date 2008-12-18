class BuildsController < ApplicationController
  # GET /builds
  # GET /builds.xml
  def index
    @p = Project.get_cache(params[:project_id])
    #    @builds = @p.builds
    @builds = Build.paginate_by_project_id(@p.id,:order =>"created_at desc" ,:page => params[:page])
  end
  def tlogs
    @p = Project.get_cache(params[:project_id])
    @build = Build.find(params[:id])
    @logs = Seleniumlog.paginate_by_project_id_and_build_id_and_status(@p.id,@build.id,1,:order =>"created_at desc" ,:page => params[:page])
    #@logs = @bulid.ture_logs
  end
  def flogs
    @p = Project.get_cache(params[:project_id])
    @build = Build.find(params[:id])
    @logs = Seleniumlog.paginate_by_project_id_and_build_id_and_status(@p.id,@build.id,0,:order =>"created_at desc" ,:page => params[:page])
  end
  # GET /builds/1
  # GE8T /builds/1.xml
  def show
    @p = Project.get_cache(params[:project_id])
    @build = Build.find(params[:id])
    @logs = Seleniumlog.paginate_by_project_id_and_build_id(@p.id,@build.id,:order =>"created_at desc" ,:page => params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @build }
    end
  end

  # GET /builds/new
  # GET /builds/new.xml
 
end
