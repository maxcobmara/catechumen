class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string  :icno
      t.string  :name
      t.string  :matrixno
      t.string  :sstatus
      t.string  :stelno
      t.string  :ssponsor
      t.integer :gender
      t.date    :sbirthdt
      t.integer :mrtlstatuscd
      t.string  :semail
      t.date    :regdate
      t.integer :intake_id
      t.integer :course_id
      t.integer :specilisation
      t.integer :group_id
      t.string  :physical
      t.string  :allergy
      t.string  :disease
      t.string  :bloodtype
      t.string  :medication
      t.text    :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
