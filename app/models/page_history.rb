# == Schema Information
# Schema version: 20080620142850
#
# Table name: page_histories
#
#  id         :integer(11)   not null, primary key
#  page_id    :integer(11)   
#  user_id    :integer(11)   
#  content    :text          
#  created_at :datetime      
#  updated_at :datetime      
#

class PageHistory < ActiveRecord::Base
end
