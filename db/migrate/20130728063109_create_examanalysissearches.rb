class CreateExamanalysissearches < ActiveRecord::Migration
  def self.up
    create_table :examanalysissearches do |t|
      t.string :examtype
      t.integer :subject_id
      t.date :examon
      t.timestamps
    end
  end

  def self.down
    drop_table :examanalysissearches
  end
end
