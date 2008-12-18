# == Schema Information
# Schema version: 20080620142850
#
# Table name: projects
#
#  id         :integer(11)   not null, primary key
#  name       :string(255)   
#  desc       :string(255)   
#  created_at :datetime      
#  updated_at :datetime      
#  owner_id   :integer(11)   
#

# == Schema Information
# Schema version: 20080502120104
#
# Table name: projects
#
#  id         :integer(11)   not null, primary key
#  name       :string(255)   
#  desc       :string(255)   
#  created_at :datetime      
#  updated_at :datetime      
#  owner_id   :integer(11)   
#

class Project < ActiveRecord::Base
  has_many :seleniumlogs
  acts_as_cached
  after_save :expire_cache
  has_many :testcases
  has_many :pages
  has_many :tickets
  has_many :builds
  has_many :project_users ,:dependent => :destroy
  has_many :users ,:through => :project_users
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  validates_presence_of :name ,:message =>"项目名称不能为空"
  validates_uniqueness_of :name ,:message => "项目名称不能重复"
end
