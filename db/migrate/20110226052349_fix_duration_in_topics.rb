class FixDurationInTopics < ActiveRecord::Migration
  def self.up
    add_column    :topics, :durahours, :integer
    add_column    :topics, :duramins,  :integer
    remove_column :topics, :duration
    add_column    :topics, :duration,  :integer
  end

  def self.down
  end
end



#remove_column :users, :name