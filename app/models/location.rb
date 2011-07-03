class Location < ActiveRecord::Base
  
  has_ancestry
  
  def self.search(search)
      if search
       find(:all, :conditions => ['code ILIKE ? or name ILIKE ?', "%#{search}%","%#{search}%"], :order => :rcode)
     else
      find(:all, :order => :code)
     end
   end
   
   def tree_gelas
     if is_root?
       gls = ""
     else
       gls = "class=\"child-of-node-#{parent_id}\""
     end
     gls
   end
   
   def location_list
      "#{code}  #{name}"
   end
   
 
 
 CLASS = [
        #  Displayed       stored in db
        [ "Building",1 ],
        [ "Floor",2 ],
        [ "Unit/Room", 3 ],
  ]

 TYPE = [
         #  Displayed       stored in db
         [ "Staff Residence",1 ],
         [ "Student Residence",2 ],
         [ "Facility",3 ],
         [ "Staff Area",4 ],
         [ "Public Area",5 ],
         [ "Other",6 ]
 ]

end
