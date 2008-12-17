# == Schema Information
# Schema version: 20080620142850
#
# Table name: project_users
#
#  id         :integer(11)   not null, primary key
#  user_id    :integer(11)   
#  project_id :integer(11)   
#  created_at :datetime      
#  updated_at :datetime      
#

# == Schema Information
# Schema version: 20080502120104
#
# Table name: project_users
#
#  id         :integer(11)   not null, primary key
#  user_id    :integer(11)   
#  project_id :integer(11)   
#  created_at :datetime      
#  updated_at :datetime      
#

class ProjectUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
end
