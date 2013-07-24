class CreateStudentsearches < ActiveRecord::Migration
  def self.up
    create_table :studentsearches do |t|
      t.string :icno
      t.string :name
      t.string :matrixno
      t.string :status
      t.string :ssponsor
      t.integer :mrtlstatuscd
      t.integer :course_id
      t.string :physical
      t.date :end_training
      t.date :intake
      t.timestamps
    end
  end

  def self.down
    drop_table :studentsearches
  end
end
