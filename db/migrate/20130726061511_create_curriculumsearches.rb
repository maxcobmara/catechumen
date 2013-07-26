class CreateCurriculumsearches < ActiveRecord::Migration
  def self.up
    create_table :curriculumsearches do |t|
      t.integer :programme_id
      t.integer :semester
      t.integer :subject
      t.integer :topic
      t.timestamps
    end
  end

  def self.down
    drop_table :curriculumsearches
  end
end
