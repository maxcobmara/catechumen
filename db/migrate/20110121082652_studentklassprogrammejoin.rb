class Studentklassprogrammejoin < ActiveRecord::Migration
  def self.up
    create_table :students_klasses_programmes, :id => false do |t|
    t.integer :student_id
    t.integer :klass_id
    t.integer :programme_id
    end
  end

  def self.down
    drop_table :students_klasses_programmes
  end
end
