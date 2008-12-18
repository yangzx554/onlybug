class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.text :content
      t.integer :user_id
      t.integer :project_id
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
