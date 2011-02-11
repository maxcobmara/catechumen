class Dropleaves < ActiveRecord::Migration
  def self.up
    drop_table :leaves
  end

  def self.down
    create_table :leaves do |t|
      
      #request	
            t.integer    :student_id        #from student	
            t.string     :leavetype         #Weekend Day, Weekend Overnight, Emergency
            t.date       :requestdt         	
            t.string     :reason	
            t.string     :address	
            t.string     :telno	
            t.date       :startdt           #required if leavetype = Weekend Overnight or Emergency	
                                            #select only saturday or sunday if leavetype = Weekend Day or Weekend Overnight
  	
            t.date       :enddt             #required if leavetype = Weekend Overnight or Emergency	
                                            #select only saturday or sunday if leavetype = Weekend Day or Weekend Overnight	

      	
            #approval	
            t.boolean    :approved      	
            t.integer    :approvedby_id   #from staff	
            t.date       :approveddate	
      

      t.timestamps
    end
  end
end