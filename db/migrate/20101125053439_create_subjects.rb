class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string  :subjectcode
      t.string  :name
      t.string  :description
      t.integer :credit
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :subjects
  end
end
