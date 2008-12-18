# == Schema Information
# Schema version: 20080620142850
#
# Table name: builds
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  version    :integer(11)   
#  created_at :datetime      
#  updated_at :datetime      
#  status     :integer(11)   
#

class Build < ActiveRecord::Base
  cattr_reader :per_page 

  @@per_page = 10
  has_many :ture_logs,:class_name => "Seleniumlog",:conditions => "status = 1 " , :order => 'created_at desc'
  has_many :false_logs,:class_name => "Seleniumlog" ,:conditions => " status = 0 ", :order =>'created_at desc'
  has_many :seleniumlogs ,:order => 'created_at desc'
  belongs_to :project
end
