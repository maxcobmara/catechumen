class AddColumn2ToAssetLoan < ActiveRecord::Migration
  def self.up
    add_column :asset_loans, :received_officer, :integer
  end

  def self.down
    remove_column :asset_loans, :received_officer
  end
end
