# == Schema Information
# Schema version: 20080620142850
#
# Table name: seleniumlogs
#
#  id          :integer(11)   not null, primary key
#  project_id  :integer(11)   
#  testcase_id :integer(11)   
#  build_id    :integer(11)   
#  status      :integer(11)   
#  created_at  :datetime      
#  updated_at  :datetime      
#  operate     :string(255)   
#  name        :string(255)   
#  expected    :string(255)   
#  actual      :string(255)   
#

class Seleniumlog < ActiveRecord::Base
  
  cattr_reader :per_page 

  @@per_page = 10
  belongs_to :project
  belongs_to :build
  belongs_to :testcase
  acts_as_cached
end
