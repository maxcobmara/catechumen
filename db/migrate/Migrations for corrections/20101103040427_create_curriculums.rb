class CreateCurriculums < ActiveRecord::Migration
  def self.up
    create_table :curriculums do |t|
      t.integer :currcode
      t.integer :curcategory
      t.string :name
      t.decimal :duration
      t.string :currversion
      t.string :durationtype
      t.string :currobjective
      t.text :currcontent
      t.string :currversions
      t.string :curractivity
      t.string :currefs
      t.string :currscope
      t.string :currdefinition
      t.string :abbrev
      t.string :currqualrec
      t.integer :approved_id
      t.date :approvedt

      t.timestamps
    end
  end

  def self.down
    drop_table :curriculums
  end
end
