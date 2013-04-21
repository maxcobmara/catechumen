class ExamresultStudentJoin < ActiveRecord::Migration
  def self.up
     create_table :examresults_students, :id => false do |t|
      t.integer :examresult_id
      t.integer :student_id
     end
  end

  def self.down
    drop_table :examresults_students
  end
end
