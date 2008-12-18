# == Schema Information
# Schema version: 20080620142850
#
# Table name: testcases
#
#  id         :integer(11)   not null, primary key
#  des        :string(255)   
#  name       :string(255)   
#  created_at :datetime      
#  updated_at :datetime      
#  project_id :integer(11)   
#  user_id    :integer(11)   
#

class Testcase < ActiveRecord::Base
  has_many :seleniumlogs
  belongs_to :project
  belongs_to :user
  acts_as_cached
  after_save :expire_cache
end
