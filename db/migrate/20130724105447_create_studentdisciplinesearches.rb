class CreateStudentdisciplinesearches < ActiveRecord::Migration
  def self.up
    create_table :studentdisciplinesearches do |t|
      t.string :name
      t.integer :programme
      t.date :intake
      t.string :matrixno
      t.timestamps
    end
  end

  def self.down
    drop_table :studentdisciplinesearches
  end
end
