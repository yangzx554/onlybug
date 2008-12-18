# == Schema Information
# Schema version: 20080620142850
#
# Table name: tickets
#
#  id          :integer(11)   not null, primary key
#  title       :string(255)   
#  desc        :string(255)   
#  user_id     :integer(11)   
#  assigned_id :integer(11)   
#  created_at  :datetime      
#  updated_at  :datetime      
#  project_id  :integer(11)   
#  state       :integer(11)   
#

# == Schema Information
# Schema version: 20080502120104
#
# Table name: tickets
#
#  id          :integer(11)   not null, primary key
#  title       :string(255)   
#  desc        :string(255)   
#  user_id     :integer(11)   
#  assigned_id :integer(11)   
#  created_at  :datetime      
#  updated_at  :datetime      
#  project_id  :integer(11)   
#  state       :integer(11)   
#

class Ticket < ActiveRecord::Base
  acts_as_cached
  acts_as_taggable
#  acts_as_ferret
  attr_accessor :tag
  attr_accessor :body
  validates_presence_of :title
  validates_presence_of :desc
  belongs_to :project
  belongs_to :assigned_user, :class_name => "User" ,:foreign_key => "assigned_id"
  belongs_to :user
  has_many :versions
  
end
