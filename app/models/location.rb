class Location < ActiveRecord::Base
  
  has_ancestry
  
  has_many :tenant, :class_name => 'Tenant', :foreign_key => 'location_id'
  has_many :loc_plan, :class_name => 'Topic', :foreign_key => 'location_id'
  has_many :assetlocation, :class_name => 'Assetloss', :foreign_key => 'losslocation_id'
  has_many :reservefac, :class_name => 'Bookingfacility', :foreign_key => 'location_id'
  has_many :assets
  
 
  
  has_many :timetables
  belongs_to  :administrator, :class_name => 'Staff', :foreign_key => 'staffadmin_id'
  
  def self.search(search)
      if search
       find(:all, :conditions => ['code ILIKE ? or name ILIKE ?', "%#{search}%","%#{search}%"], :order => :code)
     else
      find(:all, :order => :code)
     end
   end
   
   #-----
   named_scope :staff,      :conditions => { :typename => 1 }
   named_scope :student,    :conditions => { :typename => 2 }
   named_scope :facility,   :conditions => { :typename => 3 }
   
   FILTERS = [
     {:scope => "all",        :label => "All"},
     {:scope => "staff",      :label => "Staff Residences"},
     {:scope => "student",    :label => "Student Residences"},
     {:scope => "facility",   :label => "Facilities"}
   ]
   
   
   
   #---
   
   def tree_gelas
     if is_root?
       gls = ""
     else
       gls = "class=\"child-of-node-#{parent_id}\""
     end
     gls
   end
   
   def location_list
      "#{code} - #{name}"
   end
   
   

   
   def occstatus
    myid = id
    occ = Tenant.find(:all, :select => "keyreturned", :conditions => ["location_id =? AND keyreturned IS ?", myid, nil])
      if occ == []
       else
         "occupied"
       end
   end

    def currenttenant
      myid = id
      Tenant.find(:all, :select => "id", :conditions => ["location_id =?", myid]).map(&:id)
    end
   
   
 
 
 CLASS = [
        #  Displayed       stored in db
        [ "Building",1 ],
        [ "Floor",2 ],
        [ "Unit/Room", 3 ],
  ]

 TYPE = [
         #  Displayed       stored in db
         [ "Staff Residence",   1 ],
         [ "Student Residence", 2 ],
         [ "Facility",          3 ],
         [ "Staff Area",        4 ],
         [ "Public Area",       5 ],
         [ "Classroom",         6 ],
         [ "Other",             7 ]
         
 ]

end
