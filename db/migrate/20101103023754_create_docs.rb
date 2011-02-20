class CreateDocs < ActiveRecord::Migration
  def self.up
    create_table :docs do |t|
      t.integer :curriculum_id
      t.integer :cofile_id
      t.string  :name
      t.decimal :version
      t.string  :description

      t.timestamps
    end
  end

  def self.down
    drop_table :docs
  end
end
