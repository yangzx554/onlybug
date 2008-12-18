class CreateMilestones < ActiveRecord::Migration
  def self.up
    create_table :milestones do |t|
      t.integer :project_id,:user_id
      t.string :title
      t.text  :desc
      t.date :due_date
      t.timestamps
    end
  end

  def self.down
    drop_table :milestones
  end
end
