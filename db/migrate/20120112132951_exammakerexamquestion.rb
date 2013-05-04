class Exammakerexamquestion < ActiveRecord::Migration
  def self.up
  	create_table :exammakers_examquestions, :id => false do |t|
      t.integer :exammaker_id
      t.integer :examquestion_id
      
      t.timestamps
  end
  end

  def self.down
  	 drop_table :exammakers_examquestions
  end
end
