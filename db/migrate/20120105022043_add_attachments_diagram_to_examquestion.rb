class AddAttachmentsDiagramToExamquestion < ActiveRecord::Migration
  def self.up
    add_column :examquestions, :diagram_file_name, :string
    add_column :examquestions, :diagram_content_type, :string
    add_column :examquestions, :diagram_file_size, :integer
    add_column :examquestions, :diagram_updated_at, :datetime

    #others required
    add_column :examquestions, :topic_id, :integer
    add_column :examquestions, :construct, :string

    add_column :examquestions, :conform_curriculum, :boolean
    add_column :examquestions, :conform_specification, :boolean
    add_column :examquestions, :conform_opportunity, :boolean

    add_column :examquestions, :accuracy_construct, :boolean
    add_column :examquestions, :accuracy_topic, :boolean
    add_column :examquestions, :accuracy_component, :boolean

    add_column :examquestions, :fit_difficulty, :boolean
    add_column :examquestions, :fit_important, :boolean
    add_column :examquestions, :fit_fairness, :boolean

    rename_column :examquestions, :status, :difficulty
  end

  def self.down
    remove_column :examquestions, :diagram_file_name
    remove_column :examquestions, :diagram_content_type
    remove_column :examquestions, :diagram_file_size
    remove_column :examquestions, :diagram_updated_at

    remove_column :examquestions, :topic_id
    remove_column :examquestions, :construct

    remove_column :examquestions, :conform_curriculum
    remove_column :examquestions, :conform_specification
    remove_column :examquestions, :conform_opportunity

    remove_column :examquestions, :accuracy_construct
    remove_column :examquestions, :accuracy_topic
    remove_column :examquestions, :accuracy_component

    remove_column :examquestions, :fit_difficulty
    remove_column :examquestions, :fit_important
    remove_column :examquestions, :fit_fairness

    rename_column :examquestions, :difficulty, :status
  end
end
