class CreateCounsellings < ActiveRecord::Migration
  def self.up
    create_table :counsellings do |t|
      t.integer :student_id
      t.integer :cofile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :counsellings
  end
end
