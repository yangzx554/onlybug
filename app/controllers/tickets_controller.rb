class TicketsController < ApplicationController
  def new
    @tags = Tag.find(:all)
    # @p = Project.find(params[:project_id])
    @p = Project.get_cache(params[:project_id])
    @users =  @p.users
  end
  def index
    @p = Project.find(params[:project_id])
    @q = params[:q]
    if @q == nil
      @tickets = @p.tickets
    else
      @list =  @q.split(":")
      @qtpye = @list[0]
      case @qtpye
      when "tagged" then @tickets = @p.tickets.find_tagged_with(@list[1])
      when "responsible" 
        then 
        @user = User.find_by_name(@list[1])
        @tickcts =@p.tickets.find_by_assigned_id(@user.id)
      when "reported_by"
        then
        @user =User.find_by_name(@list[1])
        @tickets = @p.tickets.find_by_user_id(@user.id)
      else
        @tickets 
      end
    end
  end
  def show
    @tags = Tag.find(:all)
    @p = Project.find(params[:project_id])
    @ticket = Ticket.find(params[:id])
    list =  @ticket.tag_list.to_s.gsub(/,/,"\s")
    @ticket.tag = list
  end
  def update
    @p = Project.find(params[:project_id])
    @ticket = Ticket.find(params[:id])
    @version = Version.new
    @version.message = params[:ticket][:body]
    @version.start_state = @ticket.state
    @version.user_id = @u.id
    @ticket.tag_list = params[:ticket][:tag].gsub(/\s/,",")
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        @version.end_state =@ticket.state
        @version.ticket_id = @ticket.id
        @version.save!
        format.html do
          Event.create({:project_id=>@ticket.project_id,:user_id =>@u.id,:type_id =>1,:content_id => @ticket.id,:operate_id=>2})
          flash[:notice] = "更新成功"
          redirect_to(project_ticket_path(@p,@ticket))
        end
      else
        flash.new[:error] = @ticket.errors
        format.html redirect_to(project_ticket_path(@p,@ticket))
      end
    end
  end
  def create
    #@p = Project.find(params[:project_id])
    @p = Project.find(params[:project_id])
    @ticket = Ticket.new(params[:ticket])
    @ticket.tag_list = params[:ticket][:tag].gsub(/\s/,",")
    @ticket.user_id = @u.id
    @ticket.project_id = params[:project_id]
    @ticket.state = 0
    respond_to do|format|
      if @ticket.save
        format.html do
          Event.create({:project_id=>@ticket.project_id,:user_id =>@u.id,:type_id =>1,:content_id => @ticket.id,:operate_id=>1})
          flash[:notice] = "新建任务成功"
          redirect_to(project_ticket_path(@p,@ticket))
        end
      else
        flash.new[:error] = @ticket.errors
        render(:action =>"new")
      end
    end
  end
end
