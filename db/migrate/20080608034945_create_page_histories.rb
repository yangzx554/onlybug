class CreatePageHistories < ActiveRecord::Migration
  def self.up
    create_table :page_histories do |t|
      t.integer :page_id ,:user_id
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :page_histories
  end
end
