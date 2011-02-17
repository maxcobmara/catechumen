class CreateKlasses < ActiveRecord::Migration
  def self.up
    create_table :klasses do |t|
      t.integer :klass_no
      t.string  :klass_name
      t.integer :intake_id
      t.integer :programme_id

      t.timestamps
    end
  end

  def self.down
    drop_table :klasses
  end
end
