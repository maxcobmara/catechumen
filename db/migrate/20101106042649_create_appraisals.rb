class CreateAppraisals < ActiveRecord::Migration
  def self.up
    create_table :appraisals do |t|

      #Staff Details	
                  t.integer :staff_id              #from staff
                  t.date    :evaldt	

                  #partII	
                  t.date    :parttwodt	


                  #partIII	
                  t.decimal :pppquantity	
                  t.decimal :ppkquantity	
                  t.decimal :pppquality	
                  t.decimal :ppkquality	
                  t.decimal :pppontime	
                  t.decimal :ppkontime	
                  t.decimal :pppeffective
                  t.decimal :ppkeffective	


                  #partIV	
                  t.decimal :pppknowledge	
                  t.decimal :ppkknowledge	
                  t.decimal :ppprules	
                  t.decimal :ppkrules	
                  t.decimal :pppcommunication	
                  t.decimal :ppkcommunication

                  #partV

                  t.decimal :pppleader	
                  t.decimal :ppkleader	
                  t.decimal :pppmanage	
                  t.decimal :ppkmanage	
                  t.decimal :pppdiscipline	
                  t.decimal :ppkdisipline	
                  t.decimal :pppproactive	
                  t.decimal :ppkproactive	
                  t.decimal :ppprelate	
                  t.decimal :ppkrelate	

                  #part VI (Marks for Part II)	
                  t.decimal :pppparttwo	
                  t.decimal :ppkparttwo	


                  #part VII	
                  t.decimal :ppptotals	
                  t.decimal :ppktotals	
                  t.decimal :ppppercent	
                  t.decimal :ppkpercent	
                  t.decimal :pointsaverage	


                  #part VIII	
                  t.integer :pppyears	
                  t.integer :pppmonths	
                  t.text    :pppoverall	
                  t.text    :pppadvancemet	
                  t.integer :ppp_id                #from staff	
                  t.date    :pppevaldt	


                  #part IV	
                  t.integer :ppkyears	
                  t.integer :ppkmonths	
                  t.text    :ppkoverall	
                  t.integer :ppk_id                #from staff	
                  t.date    :ppkevaldt

            t.timestamps
    end
  end

  def self.down
    drop_table :appraisals
  end
end
