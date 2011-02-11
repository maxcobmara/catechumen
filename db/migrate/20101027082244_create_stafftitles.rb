class CreateStafftitles < ActiveRecord::Migration
  def self.up
    create_table :stafftitles do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :stafftitles
  end
end
