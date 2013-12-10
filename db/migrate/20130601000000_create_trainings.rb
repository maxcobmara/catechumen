class CreateTrainings < ActiveRecord::Migration
  def self.up
    create_table :intakes do |t|
      t.string   :name
      t.string   :description
      t.date     :register_on
      t.integer  :programme_id
      t.boolean  :is_active
      t.date     :monthyear_intake
      t.timestamps
    end
           
    create_table :academic_sessions do |t|
      t.string   :semester
      t.integer  :total_week
      t.timestamps
    end
    
    create_table :programmes do |t|
      t.string   :code
      t.string   :combo_code
      t.string   :name
      t.string   :course_type
      t.string   :ancestry
      t.integer  :ancestry_depth
      t.text     :objective
      t.integer  :duration
      t.integer  :duration_type
      t.integer  :credits
      t.integer  :status
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :programmes_subjects, :id => false do |t|
      t.integer :programme_id
      t.integer :subject_id
    end
    
    create_table :klasses do |t|
      t.string   :name
      t.integer  :intake_id
      t.integer  :programme_id
      t.integer  :subject_id
      t.timestamps
    end

    create_table :klasses_students, :id => false do |t|
      t.integer :klass_id
      t.integer :student_id
    end
    
    create_table :trainings do |t|
      t.string   :code
      t.string   :combo_code
      t.string   :name
      t.string   :course_type
      t.string   :ancestry
      t.integer  :ancestry_depth
      t.text     :objective
      t.integer  :duration
      t.integer  :duration_type
      t.integer  :credits
      t.integer  :status
      t.timestamps
    end
  end
  
  def self.down
  end
end