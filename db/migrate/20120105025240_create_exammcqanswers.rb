class CreateExammcqanswers < ActiveRecord::Migration
  def self.up
    create_table :exammcqanswers do |t|
      t.integer :examquestion_id
      t.string :sequence
      t.string :answer
      t.timestamps
    end
  end

  def self.down
    drop_table :exammcqanswers
  end
end
