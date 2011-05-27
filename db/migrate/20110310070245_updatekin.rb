class Updatekin < ActiveRecord::Migration
  def self.up
    add_column    :kins, :profession, :string
  end

  def self.down
  end
end
