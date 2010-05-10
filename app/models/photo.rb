# == Schema Information
# Schema version: 20080620142850
#
# Table name: photos
#
#  id           :integer(11)   not null, primary key
#  filename     :string(255)   
#  content_type :string(255)   
#  thumbnail    :string(255)   
#  size         :integer(11)   
#  width        :integer(11)   
#  height       :integer(11)   
#  parent_id    :integer(11)   
#  album_id     :integer(11)   
#  user_id      :integer(11)   
#  created_at   :datetime      
#  updated_at   :datetime      
#

# == Schema Information
# Schema version: 20080502120104
#
# Table name: photos
#
#  id           :integer(11)   not null, primary key
#  filename     :string(255)   
#  content_type :string(255)   
#  thumbnail    :string(255)   
#  size         :integer(11)   
#  width        :integer(11)   
#  height       :integer(11)   
#  parent_id    :integer(11)   
#  album_id     :integer(11)   
#  user_id      :integer(11)   
#  created_at   :datetime      
#  updated_at   :datetime      
#

class Photo < ActiveRecord::Base
  has_one :user
  has_attachment  :content_type => :image, 
    :storage => :file_systems, 
    :max_size => 6.megabytes,
    :thumbnails => { :thumb => '200x200', :tiny => '40x40' },
    :processor => :MiniMagick 
  #validates_as_attachment
end
