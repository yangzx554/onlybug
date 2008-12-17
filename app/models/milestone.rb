# == Schema Information
# Schema version: 20080620142850
#
# Table name: milestones
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  user_id    :integer(11)   
#  title      :string(255)   
#  desc       :text          
#  due_date   :date          
#  created_at :datetime      
#  updated_at :datetime      
#

# == Schema Information
# Schema version: 20080502120104
#
# Table name: milestones
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  user_id    :integer(11)   
#  title      :string(255)   
#  desc       :text          
#  due_date   :date          
#  created_at :datetime      
#  updated_at :datetime      
#

class Milestone < ActiveRecord::Base
end
