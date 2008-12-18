class CreatePhotos < ActiveRecord::Migration
   def self.up
    create_table :photos do |t|
      t.string  :filename,:content_type,:thumbnail
      t.integer :size,:width,:height,:parent_id,:album_id,:user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
