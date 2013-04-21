class CreateWeeklytimetables < ActiveRecord::Migration
  def self.up
    create_table :weeklytimetables do |t|
      t.integer :programme_id
      t.integer :intake_id
      t.integer :group_id
      t.date :startdate
      t.date :enddate
      t.integer :semester
      t.integer :prepared_by
      t.integer :endorsed_by

      t.timestamps
    end
  end

  def self.down
    drop_table :weeklytimetables
  end
end
