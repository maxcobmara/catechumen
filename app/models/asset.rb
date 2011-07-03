class Asset < ActiveRecord::Base
  
  before_save :save_my_vars
  belongs_to :manufacturedby, :class_name => 'Addbook', :foreign_key => 'manufacturer_id'
  belongs_to :suppliedby,     :class_name => 'Addbook', :foreign_key => 'supplier_id'
  belongs_to :location
  belongs_to :assignedto, :class_name => 'Staff', :foreign_key => 'assignedto_id'
  belongs_to :receivedby, :class_name => 'Staff', :foreign_key => 'receiver_id'
  
  validates_uniqueness_of :cardno, :scope => :assettype, :message => "This combination code has already been used"
 
  def save_my_vars
    self.assetcode = (suggested_serial_no).to_s
  end
  
 #----------------------Link to Other Page---------------------------------------------------
  
  #Link to Model Disposals
  has_many :asscd,    :class_name => 'Disposal', :foreign_key => 'asset_id' 
  
  #Link to Model AssetLoss
  has_many :asslost,    :class_name => 'Assetloss', :foreign_key => 'asset_id' #Assetname
  
  #Link to Model AssetTrack
  has_many :assetinassettrack,    :class_name => 'Assettrack', :foreign_key => 'asset_id' #Assetname
  #has_many :modelass, :class_name => 'Assettrack', :foreign_key => 'model'
  

  #has_many :assets, :foreign_key => 'asset_id'

  #has_many :assetlosses, :foreign_key => 'asset_id'
  #has_many :disposals, :foreign_key => 'disposal_id'
  has_many :assettracks
  
  #------------------------Validations------------------------------------------------------------
  
  validates_presence_of  :assettype, :cardno, :name, :category
  

    def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
    
    def self.find_main
        Addbook.find(:all, :condition => ['addbook_id IS NULL'])
    end
    
     def self.find_main
        Location.find(:all, :condition => ['location_id IS NULL'])
      end

#---------------------------------Search-------------------------------------------------------------
    
    def self.search(search)
       if search
        find(:all, :conditions => ['name ILIKE ?', "%#{search}%"])
      else
       find(:all)
      end
    end
    
    
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
    
    
    def suggested_serial_no
      st = "KKM/BPL/010619/"
      if assettype == 1
       md = "H/"
      else
       md = "I/"
      end
      st + md + syear + '/' + cardno
    end
      
      

#-----------------------Coded List-------------------------------------------------------- -  

ASSETTYPE = [
           #  Displayed       stored in db
           ["H",1],
           ["I",2]
]
    
end
