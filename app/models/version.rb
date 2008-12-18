# == Schema Information
# Schema version: 20080620142850
#
# Table name: versions
#
#  id          :integer(11)   not null, primary key
#  ticket_id   :integer(11)   
#  user_id     :integer(11)   
#  start_state :integer(11)   
#  end_state   :integer(11)   
#  message     :text          
#  created_at  :datetime      
#  updated_at  :datetime      
#

# == Schema Information
# Schema version: 20080502120104
#
# Table name: versions
#
#  id          :integer(11)   not null, primary key
#  ticket_id   :integer(11)   
#  user_id     :integer(11)   
#  start_state :integer(11)   
#  end_state   :integer(11)   
#  message     :text          
#  created_at  :datetime      
#  updated_at  :datetime      
#

class Version < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
end
