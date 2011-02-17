class KlassStudentJoin < ActiveRecord::Migration
  def self.up
    create_table :klass_students, :id => false do |t|
    t.integer :klass_id
    t.integer :student_id
    t.integer :programme_id
    end
  end

  def self.down
    drop_table :klass_students
  end
end
