class SeleniumlogsController < ApplicationController
  def index
   redirect_to project_build_path(params[:project_id],params[:build_id])
  end
  def show
    @p = Project.get_cache(params[:project_id])
    @build = Build.find(params[:build_id])
    @seleniumlog = Seleniumlog.get_cache(params[:id])
  end

  def data_seleniumlogs
    #    start = (params[:start] || 1).to_i        
    #    size = (params[:limit] || 20).to_i   
    #    sort_col = (params[:sort] || 'id')  
    #    sort_dir = (params[:dir] || 'ASC')  
    #    page = ((start/size).to_i)+1  
    @seleniumlogs = Movie.find(:all,   
      :select => "id, project_id, build_id, status, operate, name, created_at"
    ) 
    return_data = Hash.new()        
    return_data[:Total] = @seleniumlogs.count       
    return_data[:Seleniumlogs] = @seleniumlogs.collect{|u| {:id=>u.id,   
        :project_id=>u.project_id,  
        :build_id=>u.build_id,   
        :status=>u.status,   
        :operate=>u.operate,   
        :name=>u.name,   
        :created_at=>u.created_at} }        
    render :text=>return_data.to_json, :layout=>false  
  end
end
