class CreateTopicdetails < ActiveRecord::Migration
  def self.up
    create_table :topicdetails do |t|
      t.string :topic_name
      t.integer :topic_code
      t.time :duration
      t.float :version_no
      t.text :objctives
      t.text :contents
      t.time :theory
      t.time :tutorial
      t.time :practical

      t.timestamps
    end
  end

  def self.down
    drop_table :topicdetails
  end
end
