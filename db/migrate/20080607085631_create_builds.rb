class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.binary  :project_id
      t.integer  :version
      t.timestamps
    end
  end

  def self.down
    drop_table :builds
  end
end
