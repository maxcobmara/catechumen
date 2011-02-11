class CreateTravelrequests < ActiveRecord::Migration
  def self.up
    create_table :travelrequests do |t|

            t.integer    :staff_id           #from staff	
            t.string     :trcode
            	
            #travel details
      	
            t.string     :destination
            t.string     :purpose	
            t.date       :tstartdt	
            t.date       :treturndt		
            t.boolean    :owncar	
            t.boolean    :officecar	
            t.boolean    :otherscar	
            t.boolean    :train	
            t.boolean    :plane	
            t.boolean    :publict		
            t.string     :ifownwhy	
            t.boolean    :claimtype          #0=by km, 1=gantian	

      	
            #submission	
            t.date       :submission         #today or greater	
            t.integer    :replacement_id     #from staff	

      	

      	
            #hod confirmation	
            t.integer    :hod_id             #from staff	
            t.date       :hodconfirmdt       #from staff	

      t.timestamps
    end
  end

  def self.down
    drop_table :travelrequests
  end
end
