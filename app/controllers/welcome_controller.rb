class WelcomeController < ApplicationController
 
  def index
    @projects = Project.get_cache(:all)
    @events = @u.events
  end
  def show
    @users = User.find(:all)
  end
  
end
