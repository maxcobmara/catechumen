class CreateExamsearches < ActiveRecord::Migration
  def self.up
    create_table :examsearches do |t|
      t.integer :programme_id
      t.integer :subject_id
      t.timestamps
    end
  end

  def self.down
    drop_table :examsearches
  end
end
