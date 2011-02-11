class CreateKlassStudentJoins < ActiveRecord::Migration
  def self.up
    create_table :klasses_students do |t|
      t.integer :student_id
      t.integer :klass_id

      t.timestamps
    end
  end

  def self.down
    drop_table :klasses_students
  end
end
