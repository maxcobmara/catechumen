class CreatePtbudgets < ActiveRecord::Migration
  def self.up
    create_table :ptbudgets do |t|
      t.decimal :budget
      t.date :fiscalstart

      t.timestamps
    end
  end

  def self.down
    drop_table :ptbudgets
  end
end
