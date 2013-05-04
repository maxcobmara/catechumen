class Addcolumntoptschedule < ActiveRecord::Migration
  def self.up
  add_column :ptschedules, :rate_speaker, :integer
  add_column :ptschedules, :total_speaker_hour, :integer
  end

  def self.down
   remove_column :ptschedules, :rate_speaker
   remove_column :ptschedules, :total_speaker_hour
  end
end
