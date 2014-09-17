class CreateLocationDamage < ActiveRecord::Migration
  def self.up
    create_table :location_damages do |t|
      t.integer   :location_id
      t.date      :reported_on
      t.string    :description
      t.date      :repaired_on
      t.integer   :document_id
      t.date      :inspection_on
      t.integer   :login_id
      t.integer   :college_id
      t.timestamps      
    end
        
  end

  def self.down
    drop_table :location_damages
  end
end
