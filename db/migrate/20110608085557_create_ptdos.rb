class CreatePtdos < ActiveRecord::Migration
  def self.up
    create_table :ptdos do |t|
      t.integer   :ptcourse_id
      t.integer   :ptschedule_id
      t.integer   :staff_id
      t.string    :justification
      t.string    :unit_review
      t.boolean   :unit_approve
      t.string    :dept_review
      t.boolean   :dept_approve
      t.integer   :replacement_id
      t.boolean   :final_approve
      t.text      :trainee_report

      t.timestamps
    end
  end

  def self.down
    drop_table :ptdos
  end
end
