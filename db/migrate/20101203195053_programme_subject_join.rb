class ProgrammeSubjectJoin < ActiveRecord::Migration
  def self.up
    create_table :programmes_subjects, :id => false do |t|
      t.integer :programme_id
      t.integer :subject_id
    end 
  end

  def self.down
    drop_table :programmes_subjects
  end
end
