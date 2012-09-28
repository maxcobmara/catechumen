class CreateStudentDisciplineCases < ActiveRecord::Migration
  def self.up
    create_table :student_discipline_cases do |t|
      t.integer   :reported_by
      t.integer   :student_id
      t.integer   :infraction_id
      t.text      :description
      t.date      :reported_on
      t.string    :status
      t.integer   :file_id
      t.date      :case_created_on
      t.text      :investigation_notes
      t.text      :action
      t.date      :closed_at_college_on
      t.integer   :location_id
      t.text      :other_info
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
