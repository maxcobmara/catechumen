class Addfieldtoevaluatelect < ActiveRecord::Migration
  def self.up
     add_column :evaluate_lecturers, :invite_lec, :string
  end

  def self.down
    remove_column :evaluate_lecturers, :invite_lec, :string
  end
end
