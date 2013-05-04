class CreateExammakers < ActiveRecord::Migration
  def self.up
    create_table :exammakers do |t|
      t.string :name
      t.text :description
      t.integer :creator_id
      t.timestamps
    end
  end

  def self.down
    drop_table :exammakers
  end
end
