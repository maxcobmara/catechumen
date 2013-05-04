class Addcolumntoptcourse < ActiveRecord::Migration
  def self.up
	add_column :ptschedules, :branch, :string
	add_column :ptschedules, :allowance_speaker, :integer
	add_column :ptschedules, :meals, :integer
	add_column :ptschedules, :coursename, :string
	add_column :ptschedules, :description, :string
	add_column :ptschedules, :duration, :integer
	add_column :ptschedules, :duration_type, :integer
	add_column :ptschedules, :total_speaker, :integer
	add_column :ptschedules, :total_meal, :integer
	add_column :ptschedules, :big_total, :integer
	
	
  end

  def self.down
	remove_column :ptschedules, :branch
	remove_column :ptschedules, :allowance_speaker
	remove_column :ptschedules, :meals
	remove_column :ptschedules, :coursename
	remove_column :ptschedules, :description
	remove_column :ptschedules, :duration
	remove_column :ptschedules, :duration_type
  end
end
