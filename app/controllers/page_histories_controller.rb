class PageHistoriesController < ApplicationController
  # GET /page_histories
  # GET /page_histories.xml
  def index
    @page_histories = PageHistory.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_histories }
    end
  end

  # GET /page_histories/1
  # GET /page_histories/1.xml
  def show
    @page_history = PageHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_history }
    end
  end

  # GET /page_histories/new
  # GET /page_histories/new.xml
  def new
    @page_history = PageHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page_history }
    end
  end

  # GET /page_histories/1/edit
  def edit
    @page_history = PageHistory.find(params[:id])
  end

  # POST /page_histories
  # POST /page_histories.xml
  def create
    @page_history = PageHistory.new(params[:page_history])

    respond_to do |format|
      if @page_history.save
        flash[:notice] = 'PageHistory was successfully created.'
        format.html { redirect_to(@page_history) }
        format.xml  { render :xml => @page_history, :status => :created, :location => @page_history }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /page_histories/1
  # PUT /page_histories/1.xml
  def update
    @page_history = PageHistory.find(params[:id])

    respond_to do |format|
      if @page_history.update_attributes(params[:page_history])
        flash[:notice] = 'PageHistory was successfully updated.'
        format.html { redirect_to(@page_history) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page_histories/1
  # DELETE /page_histories/1.xml
  def destroy
    @page_history = PageHistory.find(params[:id])
    @page_history.destroy

    respond_to do |format|
      format.html { redirect_to(page_histories_url) }
      format.xml  { head :ok }
    end
  end
end
