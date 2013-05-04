class Fixtopic < ActiveRecord::Migration
  def self.up
     add_column :topics, :organisation, :string
     add_column :topics, :department,   :string
     add_column :topics, :date_plan,    :date
     add_column :topics, :class_id,     :integer 
     add_column :topics, :location_id,  :integer
     add_column :topics, :learning_outcome, :text
     add_column :topics, :competency,       :text
     add_column :topics, :organise_training, :text
     add_column :topics, :material_training, :text
  end

  def self.down
     remove_column :topics, :organisation
     remove_column :topics, :department
     remove_column :topics, :date_plan
     remove_column :topics, :class_id
     remove_column :topics, :location_id
     remove_column :topics, :learning_outcome
     remove_column :topics, :competency
     remove_column :topics, :organise_training
     remove_column :topics, :material_training
  end
end
