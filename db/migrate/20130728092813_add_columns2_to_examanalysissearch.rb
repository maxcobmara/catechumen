class AddColumns2ToExamanalysissearch < ActiveRecord::Migration
  def self.up
    add_column :examanalysissearches, :programme_id, :integer
  end

  def self.down
    remove_column :examanalysissearches, :programme_id
  end
end
