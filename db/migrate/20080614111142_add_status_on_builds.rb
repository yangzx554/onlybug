class AddStatusOnBuilds < ActiveRecord::Migration
  def self.up
    add_column :builds ,:status,:integer
  end

  def self.down
    remove_column :builds,:status
  end
end
