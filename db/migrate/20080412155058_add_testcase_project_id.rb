class AddTestcaseProjectId < ActiveRecord::Migration
  def self.up
    add_column :testcases,:project_id,:integer
  end

  def self.down
    remove_column :testcases,:project_id
  end
end
