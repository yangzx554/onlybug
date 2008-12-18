class CreateSeleniumlogs < ActiveRecord::Migration
  def self.up
    create_table :seleniumlogs do |t|
      t.integer  :project_id ,:testcase_id ,:build_id, :status ,:testcase_id
      t.timestamps
    end
  end

  def self.down
    drop_table :seleniumlogs
  end
end
