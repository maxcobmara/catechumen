class DropTableTopics < ActiveRecord::Migration
  def self.up
    drop_table :topics
  end

  def self.down
     create_table :topics do |t|	
          t.string   :topics
          t.integer  :staff_id	
    	
          t.timestamps
      end
  end
end
