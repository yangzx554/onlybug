# == Schema Information
# Schema version: 20080620142850
#
# Table name: events
#
#  id         :integer(11)   not null, primary key
#  content_id :integer(11)   
#  user_id    :integer(11)   
#  project_id :integer(11)   
#  operate_id :integer(11)   
#  type_id    :integer(11)   
#  created_at :datetime      
#  updated_at :datetime      
#

class Event < ActiveRecord::Base
  acts_as_cached
  after_save :expire_cache
  belongs_to :user
end
