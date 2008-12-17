class WelcomeController < ApplicationController
 
  def index
    @projects = Project.get_cache(:all)
    @events = Event.find_all_by_user_id(@u.id,:order=>"created_at Desc")
    #@events = @u.events
  end
  def show
    @users = User.find(:all)
  end
  
end
