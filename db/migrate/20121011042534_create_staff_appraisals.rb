class CreateStaffAppraisals < ActiveRecord::Migration
  def self.up
    create_table :staff_appraisals do |t|
      t.integer :staff_id
      t.date :evaluation_year
      t.boolean :submit_for_evaluation1
      t.date :submit_for_appraisal1_on
      t.decimal :eval1_part_ii
      t.decimal :eval1_quantity
      t.decimal :eval1_quality
      t.decimal :eval1_time
      t.decimal :eval1_effective
      t.decimal :eval1_knowledge
      t.decimal :eval1_rule
      t.decimal :eval1_communicate
      t.decimal :eval1_leader
      t.decimal :eval1_manage
      t.decimal :eval1_discipline
      t.decimal :eval1_proactive
      t.decimal :eval1_relate
      t.decimal :eval1_knowledge
      t.decimal :eval1_part_iii_total
      t.decimal :eval1_percent
      t.integer :eval1_work_months
      t.integer :eval1_work_years
      t.text :eval1_performance
      t.text :eval1_progress
      t.integer :evaluation1_by
      t.boolean :submit_for_evaluation2
      t.date :submit_for_evaluation2_on
      t.date :submit_for_evaluation2_on
      t.decimal :eval2_part_ii
      t.decimal :eval2_quantity
      t.decimal :eval2_quality
      t.decimal :eval2_time
      t.decimal :eval2_effective
      t.decimal :eval2_knowledge
      t.decimal :eval2_rule
      t.decimal :eval2_communicate
      t.decimal :eval2_leader
      t.decimal :eval2_manage
      t.decimal :eval2_discipline
      t.decimal :eval2_proactive
      t.decimal :eval2_relate
      t.decimal :eval2_knowledge
      t.decimal :eval2_part_iii_total
      t.decimal :eval2_percent
      t.integer :eval2_work_months
      t.integer :eval2_work_years
      t.text :eval2_performance
      t.integer :evaluation2_by
      t.boolean :is_complete
      t.date :is_complete_on

      t.timestamps
    end
  end

  def self.down
    drop_table :staff_appraisals
  end
end
