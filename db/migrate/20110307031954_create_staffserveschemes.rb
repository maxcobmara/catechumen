class CreateStaffserveschemes < ActiveRecord::Migration
  def self.up
    create_table :staffserveschemes do |t|
      t.string :name
      t.string :group_id
      t.string :classification_id

      t.timestamps
    end
  end

  def self.down
    drop_table :staffserveschemes
  end
end
