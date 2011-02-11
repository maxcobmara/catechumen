class Assetcurriculumjoin < ActiveRecord::Migration
  def self.up
    create_table :asset_curriculums, :id => false do |t|
      t.integer :asset_id
      t.integer :curriculum_id
    end
  end

  def self.down
    drop_table :asset_curriculums
  end
end
