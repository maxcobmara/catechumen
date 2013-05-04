class CreateTravelclaims < ActiveRecord::Migration
  def self.up
    create_table :travelclaims do |t|

      t.integer    :travelrequest_id           #travelrequest	

      #travel details	
      t.datetime   :tstartdt	
      t.datetime   :treturndt	
      t.decimal    :distance          #nnnnnn.n	
      t.decimal    :distancevalue     #nnnnnn.nn	
      	
      #travelclaims repeating here	
      #set claimclasstype to 1	
      #foreignkey => tcptransport_id		
      #travelclaims repeating here
      	
      t.decimal    :ptclaimsvalue    #nnnnnn.nn  calculate totals from repeating	
      	
      #allowances here	
      t.decimal    :allclaimsvalue    #nnnnnn.nn  calculate totals 	
                                      #           grade.allowance.food x days.(treturndt - tstartdt) +	
                                      #           grade.allowance.daily x days.(treturndt - tstartdt)	


      #hotelclaims repeating here	
      #set claimclasstype to 2	
      #foreignkey => tchotel_id		
      #otherclaims repeating here	
      #set claimclasstype to 3	
      #foreignkey => tcothers_id	
      t.decimal    :othclaimsvalue    #nnnnnn.nn  calculate totals from list	

      #foreignexchange	
      t.decimal    :exchvalue         #nnnnnn.nn	
      t.decimal    :exchloss          #exchvalue x 3%	

      t.decimal    :gtotal            #distancevalue + ptclaimsvalue + allclaimsvalue + othclaimsvalue + exchloss		
      t.string     :ifownwhy	
      t.boolean    :claimtype          #0=by km, 1=gantian		
     
      #submission	
      t.date       :submission         #today or greater	


      #hod confirmation
	
      t.integer    :hod_id             #from staff	
      t.date       :hodconfirmdt       #from staff	

	
      #advance	
      t.decimal    :advance            #nnnnnn.nn	
      t.decimal    :payable            #nnnnnn.nn, gtotal - advance	


      t.timestamps
    end
  end

  def self.down
    drop_table :travelclaims
  end
end
