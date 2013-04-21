class CreateResultlines < ActiveRecord::Migration
  def self.up
    create_table :resultlines do |t|
      t.decimal :total
      t.decimal :pngs17
      t.string :status
      t.string :remark
      t.integer :examresult_id
      t.integer :student_id

      t.timestamps
    end
  end

  def self.down
    drop_table :resultlines
  end
end
