class AddColumnToAssetLoan < ActiveRecord::Migration
  def self.up
    add_column :asset_loans, :loantype, :integer
  end

  def self.down
    remove_column :asset_loans, :loantype
  end
end
