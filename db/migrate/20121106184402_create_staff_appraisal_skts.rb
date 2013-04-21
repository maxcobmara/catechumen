class CreateStaffAppraisalSkts < ActiveRecord::Migration
  def self.up
    create_table :staff_appraisal_skts do |t|
      t.integer :staff_appraisal_id
      t.integer :priority
      t.string :description
      t.integer :half
      t.string :indicator
      t.string :acheivment
      t.decimal :progress
      t.text :notes
      t.boolean :is_dropped
      t.date :dropped_on
      t.string :drop_reasons

      t.timestamps
    end
  end

  def self.down
    drop_table :staff_appraisal_skts
  end
end
