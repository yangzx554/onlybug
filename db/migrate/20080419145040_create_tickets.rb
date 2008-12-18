class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :title,:desc
      t.integer :user_id ,:assigned_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
