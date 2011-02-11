class CreateDisposals < ActiveRecord::Migration
  def self.up
    create_table :disposals do |t|

            t.integer    :asset_id           #from assets
            t.boolean    :used	
            t.string     :usedduration      #show if used = true	
            t.decimal    :currentvalue      #nnnnnnn.nn	
            t.string     :opinion	
            t.string     :recommendation	
            t.boolean    :gift	
            t.boolean    :status
            
      t.timestamps
    end
  end

  def self.down
    drop_table :disposals
  end
end
