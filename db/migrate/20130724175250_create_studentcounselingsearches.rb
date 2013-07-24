class CreateStudentcounselingsearches < ActiveRecord::Migration
  def self.up
    create_table :studentcounselingsearches do |t|
      t.string :matrixno
      t.integer :case_id
      t.timestamps
    end
  end

  def self.down
    drop_table :studentcounselingsearches
  end
end
