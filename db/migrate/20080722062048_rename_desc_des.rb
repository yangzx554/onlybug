class RenameDescDes < ActiveRecord::Migration
  def self.up
    rename_column(:testcases, :desc, :des)
  end

  def self.down
    rename_column(:testcases, :des, :desc)
  end
end
