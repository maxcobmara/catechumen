class CreateAssetLosses < ActiveRecord::Migration
  def self.up
    create_table :asset_losses do |t|
      t.boolean   :form_type
      t.string    :loss_type        #dropdown: cash, asset, supplies
      t.integer   :asset_id         #lookup from asset
      t.string    :cash_type
      t.decimal   :est_value
      t.boolean   :is_used
      t.string    :ownership
      t.decimal   :value_state
      t.decimal   :value_federal
      t.integer   :location_id
      t.datetime  :lost_at
      t.text      :how_desc
      t.string    :report_code
      t.integer   :last_handled_by
      t.boolean   :is_prima_facie
      t.boolean   :is_staff_action
      t.boolean   :is_police_report_made
      t.string    :police_report_code
      t.text      :why_no_report
      t.text      :police_action_status
      t.boolean   :is_rule_broken
      t.text      :rules_broken_desc
      t.text      :preventive_action_dept
      t.integer   :prev_action_enforced_by
      t.text      :preventive_measures
      t.text      :new_measures
      t.text      :recommendations
      t.text      :surcharge_notes
      t.text      :notes
      t.integer   :investigated_by
      t.string    :investigation_code
      t.date      :investigation_completed_on
      t.text      :security_officer_notes
      t.integer   :security_officer_id
      t.string    :security_code
      t.boolean   :is_submit_to_hod
      t.integer   :endorsed_hod_by
      t.date      :endorsed_on
      t.timestamps
    end
  end

  def self.down
    drop_table :asset_losses
  end
end
