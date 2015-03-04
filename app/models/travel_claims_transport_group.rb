class TravelClaimsTransportGroup < ActiveRecord::Base
  
  def self.abcrate
    find(:all, :conditions => ['salary_low is not null'], :order => 'group_name ASC')
  end
  
  def self.derate
    find(:all, :conditions =>['salary_low is not null'], :order => 'group_name ASC')
  end
  
  #def self.midsal
    #where(id: 3).first.salary_low
  #end
  
  def self.transport_class(car_id, current_salary, abc_rate, de_rate, mid_salary)
    cnt=0
    cnt2=0
    
    if current_salary >= mid_salary 
    #group A, B or C (order - asc)
      #by salary
       for ascl in abc_rate
        if cnt==0
          if current_salary >= ascl.salary_low          
           group_sal = ascl.group_name
           cnt+=1
          end
        end
       end
      #by cc
       for ascl in abc_rate
        if cnt2==0
          if ascl.cc_low && (Vehicle.find(:first, :conditions =>['id=?', car_id]).cylinder_capacity>=ascl.cc_low)		#group A or B
            group_cc = ascl.group_name
            cnt2+=1 
          elsif ascl.cc_high && (Vehicle.find(:first, :conditions => ['id=?', car_id]).cylinder_capacity<=ascl.cc_high)  #group C
            group_cc = ascl.group_name
          end
        end
       end
       #eg: cc - a, sal - b (a<b - true)
       if group_cc && group_sal
         if group_cc < group_sal
           group = group_sal
         elsif group_sal < group_cc
           group = group_cc 
         elsif group_sal == group_cc
           group = group_sal
         end
       end 
      
    else
     #group E or D (order - desc)
       for asch in de_rate
         if asch.cc_high && (Vehicle.find(:first, :conditions => ['id=?', car_id]).cylinder_capacity <= asch.cc_high)	#group E
           group_de = asch.group_name
         elsif asch.cc_low && (Vehicle.find(:first, :conditions =>['id=?', car_id]).cylinder_capacity >= asch.cc_low)	#group D
           group_de = asch.group_name
         end
       end
       group = group_de
     end
  
   group
    
  end
  
end
