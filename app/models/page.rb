# == Schema Information
# Schema version: 20080620142850
#
# Table name: pages
#
#  id         :integer(11)   not null, primary key
#  content    :text          
#  user_id    :integer(11)   
#  project_id :integer(11)   
#  title      :string(255)   
#  created_at :datetime      
#  updated_at :datetime      
#

#require 'ferret'  
#require 'rmmseg'
class Page < ActiveRecord::Base
  acts_as_cached
  after_save :expire_cache
  belongs_to :project
#  analyzer = RMMSeg::Ferret::Analyzer.new do |tokenizer|
#    Ferret::Analysis::LowerCaseFilter.new(tokenizer)
#  end
  acts_as_cached
 # acts_as_ferret :fields => {:title=>{},:content =>{:store=>:yes,:term_vector=>:with_positions_offsets}},:analyzer =>analyzer
  validates_presence_of :title,:content
  validates_uniqueness_of :title
end
