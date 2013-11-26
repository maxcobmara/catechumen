class CreateAssetLosses < ActiveRecord::Migration
  def self.up   
    create_table :asset_losses do |t|
      t.boolean  :form_type
      t.string   :loss_type
      t.integer  :asset_id
      t.string   :cash_type
      t.decimal  :est_value
      t.boolean  :is_used
      t.string   :ownership
      t.decimal  :value_state
      t.decimal  :value_federal
      t.integer  :location_id
      t.datetime :lost_at
      t.text     :how_desc
      t.string   :report_code
      t.integer  :last_handled_by
      t.boolean  :is_prima_facie
      t.boolean  :is_staff_action
      t.boolean  :is_police_report_made
      t.string   :police_report_code
      t.text     :why_no_report
      t.text     :police_action_status
      t.boolean  :is_rule_broken
      t.text     :rules_broken_desc
      t.text     :preventive_action_dept
      t.integer  :prev_action_enforced_by
      t.text     :preventive_measures
      t.text     :new_measures
      t.text     :recommendations
      t.text     :surcharge_notes
      t.text     :notes
      t.integer  :investigated_by
      t.string   :investigation_code
      t.date     :investigation_completed_on
      t.text     :security_officer_notes
      t.integer  :security_officer_id
      t.string   :security_code
      t.boolean  :is_submit_to_hod
      t.integer  :endorsed_hod_by
      t.date     :endorsed_on
      t.boolean  :is_writeoff
      t.integer  :document_id
      t.timestamps
    end
    
    create_table :assetlosses do |t|
      t.string   :losstype
      t.decimal  :estvalue
      t.integer  :asset_id
      t.integer  :part_id
      t.integer  :losslocation_id
      t.datetime :lossdt
      t.string   :losshow
      t.integer  :lossstafflast_id
      t.boolean  :laststaffcase
      t.boolean  :laststaffstop
      t.boolean  :poreport
      t.string   :porepno
      t.string   :poaction
      t.string   :ponoreportwhy
      t.string   :preventpast
      t.string   :preventfuture
      t.string   :remarks
      t.integer  :hod_id
      t.date     :hodendorsedt
      t.string   :moneytype
      t.boolean  :new
      t.string   :reportcode
      t.integer  :so_id
      t.boolean  :sostop
      t.date     :sostopdt
      t.string   :soaction
      t.boolean  :ownerstop
      t.date     :ownerstopdt
      t.string   :owneraction
      t.boolean  :supstop
      t.date     :supstopdt
      t.string   :supaction
      t.boolean  :rulesbroken
      t.string   :newrule
      t.integer  :newrule_id
      t.string   :nrrecommend
      t.boolean  :surcharge
      t.decimal  :scvalue
      t.string   :screason
      t.integer  :sio_id
      t.integer  :ssecurity_id
      t.date     :closedt
      t.timestamps
    end
  end
  
  def self.down
  end
end

 