class CreateMentors < ActiveRecord::Migration
  def self.up
    create_table :mentors do |t|
      t.integer :staff_id
      t.date :mentor_date
      t.string :remark

      t.timestamps
    end
  end

  def self.down
    drop_table :mentors
  end
end
