class Residence < ActiveRecord::Base
  
  #Residence/Asset relationship see "code for repeating asset" below
  has_many :assetloss, :foreign_key => 'losslocation_id'
  
  belongs_to :staffname, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :admin, :class_name => 'Staff', :foreign_key => 'staffadmin_id'
  belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
  belongs_to :staff, :foreign_key => 'asset_id'
  
  #Link to Model AssetLoss
  #has_many :assetlocation,    :class_name => 'Assetloss', :foreign_key => 'losslocation_id'
  
  #Link to Model Timetableentry
  #has_many :residence,  :class_name => 'Time_table_entry', :foreign_key => 'residence_id'
  
  
  has_many :substructure, :class_name => 'Residence', :foreign_key => 'parent_id'
  belongs_to :structure, :class_name => 'Residence', :foreign_key => 'parent_id'
  
  validates_uniqueness_of :rescode, :message => "- Location code must be unique"
  validates_presence_of  :rescode, :message => "- Location Code must be filled"
  validates_presence_of :resname, :message => "- Location Name must be filled"

  def self.find_main
     Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
   
   def self.find_main
       Student.find(:all, :condition => ['student_id IS NULL'])
   end
   
   #def self.find_main
      #Asset.find(:all, :condition => ['asset_id IS NULL'])
   #end
   
   def self.search(search)
      if search
       find(:all, :conditions => ['rescode ILIKE ? or resname ILIKE ?', "%#{search}%","%#{search}%"], :order => :rescode)
     else
      find(:all, :order => :rescode)
     end
   end
   
   def parentlocation_with_code_and_name
       "#{rescode} #{'      '} #{resname}"
   end
   
  CLASS = [
        #  Displayed       stored in db
        [ "Building",1 ],
        [ "Floor",2 ],
        [ "Unit", 3 ],
        [ "Room", 4 ],
        [ "Bed", 5 ]
  ]
  
 TYPE = [
         #  Displayed       stored in db
         [ "Staff Residence",1 ],
         [ "Student Residence",2 ],
         [ "Facility",3 ],
         [ "Staff Area",4 ],
         [ "Other",5 ],
 ]
  validates_presence_of    :rescode, :resname 
  validates_uniqueness_of  :rescode
  
  # code for repeating asset
   has_many :assets, :dependent => :destroy, :foreign_key => 'location_id'

   def new_asset_attributes=(asset_attributes)
     asset_attributes.each do |attributes|
       assets.build(attributes)
     end
   end

   after_update :save_assets

   def existing_asset_attributes=(asset_attributes)
     assets.reject(&:new_record?).each do |asset|
       attributes = asset_attributes[asset.id.to_s]
       if attributes
         asset.attributes = attributes
       else
         assets.delete(asset)
       end
     end
   end

   def save_assets
     assets.each do |asset|
       asset.save(false)
     end
   end
end
