class Fixdocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :feedback_sent, :boolean
    add_column :documents, :action_by, :integer
    add_column :documents, :received, :boolean
    add_column :documents, :received_date, :date
  end

  def self.down
     remove_column :documents, :feedback_sent
     remove_column :documents, :action_by
     remove_column :documents, :received
     remove_column :documents, :received_date
  end
end
