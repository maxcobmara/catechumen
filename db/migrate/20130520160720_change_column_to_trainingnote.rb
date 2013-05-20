class ChangeColumnToTrainingnote < ActiveRecord::Migration
  def self.up
    add_column :trainingnotes, :topicdetail_id, :integer
    remove_column :trainingnotes, :topic_id
  end
  def self.down
    remove_column :trainingnotes, :topicdetail_id
    add_column :trainingnotes, :topic_id, :integer
  end
end
