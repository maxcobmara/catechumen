class CreateStaffemployschemes < ActiveRecord::Migration
  def self.up
    create_table :staffemployschemes do |t|
      t.string  :glass
      t.string  :name

      t.timestamps
    end
  end

  def self.down
    drop_table :staffemployschemes
  end
end
