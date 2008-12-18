class AddPhotoId < ActiveRecord::Migration
  def self.up
    add_column :users ,:photo_id,:integer
  end

  def self.down
    remove_column :users ,:photo_id
  end
end
