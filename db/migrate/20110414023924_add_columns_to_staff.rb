class AddColumnsToStaff < ActiveRecord::Migration
  def self.up
    add_column    :staffs, :pension_confirm_date,     :date
    add_column    :staffs, :wealth_decleration_date,  :date
    add_column    :staffs, :promotion_date,           :date
    add_column    :staffs, :reconfirmation_date,      :date
    add_column    :staffs, :to_current_grade_date,    :date
    add_column    :staffs, :starting_salary,          :decimal
    
    
  end

  def self.down
  end
end
