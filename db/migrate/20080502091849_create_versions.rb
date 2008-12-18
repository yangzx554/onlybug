class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.integer :ticket_id ,:user_id ,:start_state,:end_state
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :versions
  end
end
