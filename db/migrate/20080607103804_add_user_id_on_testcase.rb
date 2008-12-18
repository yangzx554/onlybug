class AddUserIdOnTestcase < ActiveRecord::Migration
  def self.up
    add_column :testcases ,:user_id,:integer
  end

  def self.down
    remove :testcases,:user_id
  end
end
