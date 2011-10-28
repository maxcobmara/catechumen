class FixIntakeStudent < ActiveRecord::Migration
  def self.up
    # migration for intake - remove intake_id and replace with intake
    remove_column :students,  :intake_id
    add_column    :students,  :intake,   :date
  end

  def self.down
    remove_column :students,  :intake, :date
    add_column    :students,  :intake_id, :integer
  end
end
