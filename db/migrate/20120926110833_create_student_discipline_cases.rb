class CreateStudentDisciplineCases < ActiveRecord::Migration
  def self.up
    create_table :student_discipline_cases do |t|
      #initial report
      t.integer   :reported_by
      t.integer   :student_id
      t.integer   :infraction_id
      t.text      :description
      t.date      :reported_on
      t.integer   :assigned_to
      t.date      :assigned_on
      t.string    :status
      t.integer   :file_id
      
      #level1 processing
      t.text      :investigation_notes
      t.string    :action_type
      t.text      :other_info
      t.date      :case_created_on
      t.text      :action
      t.integer   :location_id
      t.integer   :assigned2_to
      t.date      :assigned2_on
    
      #level2 processing
      t.boolean   :is_innocent
      t.date      :closed_at_college_on
      t.date      :sent_to_board_on
      t.date      :board_meeting_on
      t.date      :board_decision_on
      t.text      :board_decision
      t.date      :appeal_on
      t.text      :appeal_decision
      t.date      :appeal_decision_on
      t.timestamps
    end
  end

  def self.down
    drop_table :student_discipline_cases
  end
end
