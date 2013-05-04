class Updatecolumnsdiciplines < ActiveRecord::Migration
  def self.up
    change_column :sdiciplines,  :casedt,    :datetime
    add_column :sdiciplines,  :reportteddt,    :date
  end

  def self.down
    remove_column :sdiciplines,  :casedt
    remove_column :sdiciplines,  :reportteddt
  end
end
