class CreateStaffAppraisals < ActiveRecord::Migration
  def self.up
    create_table :staff_appraisals do |t|
      
      t.integer	  :staff_id
      t.date	    :evaluation_year
      t.integer	  :eval1_by
      t.integer	  :eval2_by
      t.boolean	  :is_skt_submit
      t.date	    :skt_submit_on
      t.boolean	  :is_skt_endorsed
      t.date	    :skt_endorsed_on
      t.text	    :skt_pyd_report
      t.boolean	  :is_skt_pyd_report_done
      t.date	    :skt_pyd_report_on
      t.text	    :skt_ppp_report
      t.boolean	  :is_skt_ppp_report_done
      t.date	    :skt_ppp_report_on
      t.boolean	  :is_submit_for_evaluation
      t.date	    :submit_for_evaluation_on
      t.integer	  :g1_questions
      t.integer	  :g2_questions
      t.integer	  :g3_questions
      
      #Questions for Eval 1
      t.decimal	:e1g1q1
      t.decimal	:e1g1q2
      t.decimal	:e1g1q3
      t.decimal	:e1g1q4
      t.decimal	:e1g1q5
      t.decimal	:e1g1_total
      t.decimal	:e1g1_percent
      t.integer	:g3_questions
      t.decimal	:e1g2q1
      t.decimal	:e1g2q2
      t.decimal	:e1g2q3
      t.decimal	:e1g2q4
      t.decimal	:e1g2_total
      t.decimal	:e1g2_percent
      t.decimal	:e1g3q1
      t.decimal	:e1g3q2
      t.decimal	:e1g3q3
      t.decimal	:e1g3q4
      t.decimal	:e1g3q5
      t.decimal	:e1g3_total
      t.decimal	:e1g3_percent
      t.decimal	:e1g4
      t.decimal	:e1g4_percent
      t.decimal	:e1_total
      t.integer	:e1_years
      t.integer	:e1_months
      t.text	  :e1_performance
      t.text	  :e1_progress
      t.boolean	:is_submit_e2
      t.date	  :submit_e2_on
      
      #Eval 2
      t.decimal	:e2g1q1
      t.decimal	:e2g1q2
      t.decimal	:e2g1q3
      t.decimal	:e2g1q4
      t.decimal	:e2g1q5
      t.decimal	:e2g1_total
      t.decimal	:e2g1_percent
      t.decimal	:e2g2q1
      t.decimal	:e2g2q2
      t.decimal	:e2g2q3
      t.decimal	:e2g2q4
      t.decimal	:e2g2_total
      t.decimal	:e2g2_percent
      t.decimal	:e2g3q1
      t.decimal	:e2g3q2
      t.decimal	:e2g3q3
      t.decimal	:e2g3q4
      t.decimal	:e2g3q5
      t.decimal	:e2g3_total
      t.decimal	:e2g3_percent
      t.decimal	:e2g4
      t.decimal	:e2g4_percent
      t.decimal	:e2_total
      t.integer	:e2_years
      t.integer	:e2_months
      t.text	  :e2_performance
      t.decimal	:evaluation_total
      t.boolean	:is_complete
      t.date	  :is_completed_on

      t.timestamps
    end
  end

  def self.down
    drop_table :staff_appraisals
  end
end
