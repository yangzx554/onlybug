class AddAssertOnSeleniumlogs < ActiveRecord::Migration
  def self.up
    add_column :seleniumlogs,:expected,:string
    add_column :seleniumlogs, :actual,:string
  end

  def self.down
    remove_column :seleniumlogs, :expected
    remove_column :seleniumlogs, :actual
    ture
  end
end
