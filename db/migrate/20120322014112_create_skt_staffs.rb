class CreateSktStaffs < ActiveRecord::Migration
  def self.up
    create_table :skt_staffs do |t|
      t.date :datepyd_part1
      t.date :dateppp_part1
      t.string :report_pyd
      t.string :report_ppp
      t.date :datereport_pyd
      t.date :datereport_ppp
      t.date :date_performance
      t.integer :pyd_id
      t.integer :pp_id
      t.timestamps
    end
  end

  def self.down
    drop_table :skt_staffs
  end
end
