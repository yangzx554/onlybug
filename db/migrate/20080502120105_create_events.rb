class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :content_id,:user_id,:project_id,:operate_id,:type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
