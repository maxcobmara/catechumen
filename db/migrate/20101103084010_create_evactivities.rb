class CreateEvactivities < ActiveRecord::Migration
  def self.up
    create_table :evactivities do |t|
      t.integer :appraisal_id
      t.date    :evaldt
      t.string  :evactivity
      t.string  :actlevel
      t.date    :actdt

      t.timestamps
    end
  end

  def self.down
    drop_table :evactivities
  end
end
