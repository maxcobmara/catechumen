class Asset < ActiveRecord::Base
  
  before_save :save_my_vars
  
  validates_presence_of  :assettype, :cardno, :receiveddate
  validates_uniqueness_of :cardno, :scope => :assettype, :message => "This combination code has already been used"
  
  def save_my_vars
    self.assetcode = (suggested_serial_no).to_s
  end
  
 #----------------------Link to Other Page---------------------------------------------------
  
  #Link to Model Disposals
  has_one :disposals
  
  #Link to Model AssetLoss
  has_many :asslost,    :class_name => 'Assetloss', :foreign_key => 'asset_id' #Assetname
  
  #Link to Model AssetTrack
  has_many :assetinassettrack,    :class_name => 'Assettrack', :foreign_key => 'asset_id' #Assetname
  
  #Link to Model Travelrequest
  has_many :travelcar,    :class_name => 'Travelrequest', :foreign_key => 'asset_id' #Assetname
  
  #has_many :modelass, :class_name => 'Assettrack', :foreign_key => 'model'
  #has_many :assets, :foreign_key => 'asset_id'
  #has_many :assetlosses, :foreign_key => 'asset_id'
  #has_many :disposals, :foreign_key => 'disposal_id'
  #has_many :assettracks
  
  #------------------------Belong to other Pages------------------------------------------------------------
   belongs_to :manufacturedby, :class_name => 'Addbook', :foreign_key => 'manufacturer_id'
  belongs_to :suppliedby,   :class_name => 'Addbook', :foreign_key => 'supplier_id'
  belongs_to :location
  belongs_to :assignedto,   :class_name => 'Staff', :foreign_key => 'assignedto_id'
  belongs_to :receivedby,   :class_name => 'Staff', :foreign_key => 'receiver_id'
  belongs_to :category,     :class_name => 'Assetcategory', :foreign_key => 'category_id'
  #belongs_to :subcategory,  :class_name => 'Assetcategory', :foreign_key => 'subcategory_id'
  
  
  #-------------------------Belong to other Pages----------------------------------------------------
  
    def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
    
    def self.find_main
        Addbook.find(:all, :condition => ['addbook_id IS NULL'])
    end
    
    def self.find_main
    	Location.find(:all, :condition => ['location_id IS NULL'])
    end
    
    def asset_car
      "#{name} - #{registration}"
    end

#---------------------------------Search-------------------------------------------------------------
    
    def self.search(search)
       if search
        find(:all, :conditions => ['name LIKE ? or subcategory ILIKE ?', "%#{search}%", "%#{search}%"])
      else
       find(:all)
      end
    end
    
#----------------------- stuff for category------------------------------------------------------------
  
  #def subcategory_name
 #   subcategory.description if subcategory
  #end
  
 # def subcategory_name=(name)
 #   self.subcategory = Subcategory.find_by_description(description) unless description.blank?
 # end


 
#----------------------- code for repeating field additional number----------------------------------------
    has_many :assetnums, :dependent => :destroy

    def new_assetnum_attributes=(assetnum_attributes)
      assetnum_attributes.each do |attributes|
        assetnums.build(attributes)
      end
    end

    after_update :save_assetnums

    def existing_assetnum_attributes=(assetnum_attributes)
      assetnums.reject(&:new_record?).each do |assetnum|
        attributes = assetnum_attributes[assetnum.id.to_s]
        if attributes
          assetnum.attributes = attributes
        else
          assetnums.delete(assetnum)
        end
      end
    end

    def save_assetnums
      assetnums.each do |assetnum|
        assetnum.save(false)
      end
    end
    

#------------------------code for repeating field maintenance information-------------------------------------
    has_many :maints, :dependent => :destroy

    def new_maint_attributes=(maint_attributes)
           maint_attributes.each do |attributes|
           maints.build(attributes)
    end
    end

        after_update :save_maints

    def existing_maint_attributes=(maint_attributes)
           maints.reject(&:new_record?).each do |maint|
          attributes = maint_attributes[maint.id.to_s]
            if attributes
             maint.attributes = attributes
             else
              maints.delete(maint)
             end
           end
    end

         def save_maints
          maints.each do |maint|
            maint.save(false)
          end
    end

#------------------------Declaration----------------------------------------------------    
    def bil
       v=1
    end
    
    def gbtype
      (Asset::ASSETTYPE.find_all{|disp, value| value == assettype}).map {|disp, value| disp}
    end
    
    def syear
      receiveddate.year.to_s
    end


    def sv
      Asset.last.id + 1
    end
    
    def asset_detail
       "#{subcategory}/#{name}"
     end
    
    
    def suggested_serial_no
      st = "JPM/APMM/PL/"
      if assettype == 1
       md = "H/"
      else
       md = "I/"
      end
      st + md + syear + '/' + cardno
    end
    
    def location_for_asset
    if location.blank?
      "-"
    else
      location.name
    end
    
 
  end
#-----------------------------------------code for data no longer exist in database---------------------------------      
    def assigned_details 
       suid = assignedto_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     

       if assignedto_id == nil
          "" 
       elsif checker == []
         "Staff No Longer Exists" 
       else
         assignedto.name #21/11/2011 - shaliza changed 'staff_name_with_position' to name only
       end
     end
     
      
     def position_details #21/11/2011 - Shaliza added code for position if no longer exist.(avoid in kewpa2 error)
        suid = assignedto_id.to_a
        exists = Staff.find(:all, :select => "id").map(&:id)
        checker = suid & exists     

        if assignedto_id == nil
           "" 
        elsif checker == []
          "Position No Longer Exists" 
        else
          assignedto.position_for_staff
        end
      end     

#-----------------------Coded List----------------------------------------------------------------------------------------  

ASSETTYPE = [
           #  Displayed       stored in db
           ["H",1],
           ["I",2]
]

SCN = [
           #  Displayed       stored in db
           ["Malaysia",       60],
           ["United States",  1],
           ["United Kingdom", 44],
           ["Taiwan",         886],
           ["Phillipines",    63]
]

ETI = [
           #  Displayed       stored in db
           ["Petrol",   1],
           ["Diesel",   2],
           ["Gas",      3],
           ["Hybrid",   4]
]
    
end
