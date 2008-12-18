class AddStateId < ActiveRecord::Migration
  def self.up
    add_column :tickets ,:state,:integer # 0 new 1 open 2 closed 3 reopen  4 resolved
  end

  def self.down
    remove_column :tickets ,:state
  end
end
