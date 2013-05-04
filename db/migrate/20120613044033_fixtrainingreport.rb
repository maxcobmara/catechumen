class Fixtrainingreport < ActiveRecord::Migration
  def self.up
    add_column :trainingreports, :topic_id, :integer
  end

  def self.down
    remove_column :trainingreports, :topic_id, :integer
  end
end
