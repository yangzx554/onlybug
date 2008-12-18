class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  def index
    #    @pages = Page.find_with_ferret('美女')
    @p = Project.get_cache(params[:project_id])
  end

  # GET /pages/1= 
  # GET /pages/1.xmlend
  def show
    if params[:project_id] != nil
    @p = Project.get_cache(params[:project_id])
    end
    @page = Page.get_cache(params[:id])
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    unless params[:project_id] == nil
      @p =Project.get_cache(params[:project_id])
    end
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      @page.user_id = @u.id
      @page.project_id = params[:project_id] unless params[:project_id] == nil
      if @page.save
        Event.create({:project_id=>@page.project_id,:user_id =>@u.id,:type_id =>2,:content_id => @page.id,:operate_id=>1})
        flash[:notice] = '页面创建成功'
        if params[:project_id] == nil
          format.html { redirect_to(@page) }
        else
          format.html {redirect_to project_page_path(@page.project_id,@page)}
        end
      else
        if params[:project_id] == nil 
          format.html { render :action => "new" }
        else
          format.html {redirect_to(new_project_page_path(@p))}
        end
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
    
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
end
