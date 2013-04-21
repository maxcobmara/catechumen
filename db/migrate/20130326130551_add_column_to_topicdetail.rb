class AddColumnToTopicdetail < ActiveRecord::Migration
  def self.up
    add_column :topicdetails, :prepared_by, :integer
  end

  def self.down
    remove_column :topicdetails, :prepared_by
  end
end
