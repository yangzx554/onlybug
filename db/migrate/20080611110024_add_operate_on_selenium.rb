class AddOperateOnSelenium < ActiveRecord::Migration
  def self.up
    add_column :seleniumlogs,:operate,:string
  end

  def self.down
    remove_column :seleniumlogs,:operate
  end
end
