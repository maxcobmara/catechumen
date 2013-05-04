class CreateAverageLecturers < ActiveRecord::Migration
  def self.up
    create_table :average_lecturers do |t|
      t.integer :lecturer_id
      t.integer :programme_id
      t.integer :lesson_topic
      t.string  :dissactifaction
      t.string  :recommend_for_improvement
      t.string  :summary_evaluation
      t.string  :evaluate_category
      t.string  :support_justify
      t.integer :principal_id
      t.date    :principal_date
      t.timestamps
    end
  end

  def self.down
    drop_table :average_lecturers
  end
end
