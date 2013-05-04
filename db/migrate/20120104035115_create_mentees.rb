class CreateMentees < ActiveRecord::Migration
  def self.up
    create_table :mentees do |t|
      t.integer :student_id
      t.integer :mentor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mentees
  end
end
