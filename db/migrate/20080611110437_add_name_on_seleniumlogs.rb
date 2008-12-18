class AddNameOnSeleniumlogs < ActiveRecord::Migration
  def self.up
    add_column :seleniumlogs,:name,:string
  end

  def self.down
    remove_column :seleniumlogs,:name
  end
end
