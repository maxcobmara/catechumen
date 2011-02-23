class Corrections < ActiveRecord::Migration
  def self.up
    drop_table :stafftitles
    drop_table :students_klasses_programmes
    remove_column :assets, :location
    remove_column :assets, :residence_id
    remove_column :trainneeds, :appraisal_id
  end

  def self.down
    create_table :stafftitles do |t|
      t.string :name
      t.timestamps
    end
    
    add_column :assets, :location_id, :integer
    add_column :assets, :residence_id, :integer
    add_column :trainneeds, :appraisal_id, :integer
  end
end
