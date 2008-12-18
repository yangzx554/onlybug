class CreateProjectUsers < ActiveRecord::Migration
  def self.up
    create_table :project_users do |t|
      t.integer :user_id ,:project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :project_users
  end
end
