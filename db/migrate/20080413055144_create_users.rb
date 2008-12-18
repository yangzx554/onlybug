class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name,:email,:password_hash,:login_key
      t.datetime :login_key_expires_at,:last_seen_at
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
