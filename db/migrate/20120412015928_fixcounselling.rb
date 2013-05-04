class Fixcounselling < ActiveRecord::Migration
  def self.up
    add_column :sdiciplines, :principal_takeaction, :string
    add_column :sdiciplines, :principal_investigation, :string
    add_column :sdiciplines, :principal_datetakeaction, :date
    
  end

  def self.down
    remove_column :sdiciplines, :principal_takeaction, :string
    remove_column :sdiciplines, :principal_investigation, :string
    remove_column :sdiciplines, :principal_datetakeaction, :date
  end
end
