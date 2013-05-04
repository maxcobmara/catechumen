class CreateExworks < ActiveRecord::Migration
  def self.up
    create_table :exworks do |t|
      t.string :organisation_name
      t.string :position_name
      t.string :place
      t.integer :student_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :exworks
  end
end
