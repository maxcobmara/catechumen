class CreateAcademicSessions < ActiveRecord::Migration
  def self.up
    create_table :academic_sessions do |t|
      t.string :semester
      t.integer :total_week

      t.timestamps
    end
  end

  def self.down
    drop_table :academic_sessions
  end
end
