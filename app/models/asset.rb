class Asset < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic,
  #controller searches, variables, lists, relationship checking

  before_save :save_my_vars, :set_location

  validates_presence_of :assignedto_id, :if => :must_assign_if_loanable?
  #validates_presence_of  :category_id, :typename
  #validates_uniqueness_of :cardno, :scope => :assettype, :message => "This combination code has already been used"

  belongs_to :manufacturedby, :class_name => 'AddressBook', :foreign_key => 'manufacturer_id'
  belongs_to :suppliedby,     :class_name => 'AddressBook', :foreign_key => 'supplier_id'
  belongs_to :assignedto,   :class_name => 'Staff', :foreign_key => 'assignedto_id'
  belongs_to :receivedby,   :class_name => 'Staff', :foreign_key => 'receiver_id'
  belongs_to :category,     :class_name => 'Assetcategory', :foreign_key => 'category_id'
  #belongs_to :subcategory,  :class_name => 'Assetcategory', :foreign_key => 'subcategory_id'
  attr_accessor :cardno2    #added - 4 Oct 2013

  has_many :asset_defects
  has_one :asset_disposal       #Link to Model asset_disposals
  has_one :asset_loss        #Link to Model AssetLoss
  has_many :asset_loans

  has_many :maints, :dependent => :destroy
  accepts_nested_attributes_for :maints, :allow_destroy => true , :reject_if => lambda { |a| a[:details].blank? }

  has_many :asset_placements, :dependent => :destroy
  accepts_nested_attributes_for :asset_placements, :allow_destroy => true , :reject_if => lambda { |a| a[:location_id].blank? }
  has_many  :locations, :through => :asset_placements


  def must_assign_if_loanable?
    bookable?
  end


  def save_my_vars
    if assetcode == nil
      self.assetcode = (suggested_serial_no).to_s
      if assettype == 2
          self.cardno = cardno2 + '-'+ quantity.to_s              #added - 4 Oct 2013 - quantity(form value)
          self.quantity = quantity.to_i - cardno2.to_i + 1        #added - 4 Oct 2013
      end
    end
  end

  def code_asset
    "#{assetcode} - #{name}"
  end


  def set_location
    if asset_placements.blank?
    else
     self.location_id = asset_placements.last[:location_id]
     self.assignedto_id = asset_placements.last[:staff_id]
    end
  end




  #------------------------Filters------------------------------------------------------------

  def self.search(search)
     if search
      find(:all, :conditions => ['name ILIKE ? OR typename ILIKE ? OR assetcode ILIKE?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

  def monotone
    [:assetcode].split("/")[4]
  end

  def self.search(search)
    if search
      #find(:all, :conditions => ['substring(assetcode, 18, 2 ) =? AND assettype =?', "#{search}", 2])
      find(:all,:conditions => ['assetcode ILIKE ? or name ILIKE ?', "#{search}%", "#{search}%"])
    else
      find(:all, :conditions => ['assettype =?',  2])
    end
  end



  def non_active_assets
    lost = AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)
    disposed = AssetDisposal.find(:all, :select => :asset_id).map(&:asset_id)
    lost + disposed
  end

  def assets_that_are_lost
    AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)
  end

  def assets_that_are_disposed
    disposed = AssetDisposal.find(:all, :select => :asset_id).map(&:asset_id)
  end

  def am_i_gone
    asset = Array(self.id)
    disposed = AssetDisposal.find(:all, :select => :asset_id).map(&:asset_id)
    lost = AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)
    gone = disposed + lost
    am_i = asset & gone
    if am_i == []
      false
    else
      true
    end
  end

  def self.on_loan      #loanables
    find(:all, :conditions => ['bookable = ? AND id NOT IN (?)', true, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id)])
  end

  named_scope :all
  named_scope :active,        :conditions =>  ["id not in (?) OR id not in (?)", AssetDisposal.find(:all, :select => :asset_id).map(&:asset_id), AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :fixed,         :conditions =>  ["assettype =? ", 1]
  named_scope :maintainable,   :conditions =>  ["is_maintainable =? ", true]
  named_scope :inventory,     :conditions =>  ["assettype =? ", 2]
  named_scope :disposal,      :conditions =>  ["is_disposed =? AND id not in (?)", true, AssetDisposal.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :disposed,      :conditions =>  ["id in (?)", AssetDisposal.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :disposal,      :conditions =>  ["is_disposed =? AND id not in (?)", true, AssetDisposal.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :markaslost,    :conditions =>  ["mark_as_lost =? AND id not in (?)", true, AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :lost,          :conditions =>  ["id in (?)", AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)]
  #pending asset requested for loan should not available for reservation
  named_scope :onloan,        :conditions =>  ["id in (?)", Asset.on_loan, AssetLoan.find(:all, :conditions=>['is_approved IS true AND is_returned IS NOT true'],:select => :asset_id).map(&:asset_id) ]
  named_scope :pendingloan,   :conditions =>  ["id in (?) and id in (?)", Asset.on_loan, AssetLoan.find(:all, :conditions=>['is_approved is not true AND is_returned is not true'],:select => :asset_id).map(&:asset_id) ]
  named_scope :pendingloan,   :conditions =>  ["id in (?)", AssetLoan.find(:all, :conditions=>['is_approved is not true AND is_returned is not true'],:select => :asset_id).map(&:asset_id) ]
  named_scope :available,     :conditions =>  ["id in (?) and id not in (?)", Asset.on_loan, AssetLoan.find(:all, :conditions=>['is_returned is not true'],:select => :asset_id).map(&:asset_id) ]
  #named_scope :itdept,        :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:first, :conditions=>['unit=?',"Teknologi Maklumat"]).subtree.map(&:staff_id)]

  named_scope :itdept,        :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Teknologi Maklumat"]).map(&:staff_id)]
  named_scope :hotelunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Perhotelan"]).map(&:staff_id)]
  named_scope :libraryunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Perpustakaan"]).map(&:staff_id)]

  named_scope :sumbermanusiaunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Sumber Manusia"]).map(&:staff_id)]

  #named_scope :counterunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Kaunter"]).map(&:staff_id)]
  named_scope :engineeringunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Kejuruteraan"]).map(&:staff_id)]
  #named_scope :financestoreunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Kewangan & Stor"]).map(&:staff_id)]
  named_scope :financeaccountunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Kewangan & Akaun"]).map(&:staff_id)]
  named_scope :assetstoreunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Aset & Stor"]).map(&:staff_id)]
  #named_scope :serviceunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Perkhidmatan"]).map(&:staff_id)]
  named_scope :generaladminunit,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Pentadbiran Am"]).map(&:staff_id)]
  named_scope :radiografi,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Radiografi"]).map(&:staff_id)]
  named_scope :nursing,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Kejururawatan"]).map(&:staff_id)]
  named_scope :fisioterapi,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Jurupulih Perubatan Anggota (Fisioterapi)"]).map(&:staff_id)]
  named_scope :carakerja,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Jurupulih Perubatan Cara Kerja"]).map(&:staff_id)]
  named_scope :pemperubatan,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Penolong Pegawai Perubatan"]).map(&:staff_id)]
  named_scope :pengkhususan,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Pengkhususan"]).map(&:staff_id)]
  named_scope :perubatanasas,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Sains Perubatan Asas"]).map(&:staff_id)]
  named_scope :anatomi,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Anatomi & Fisiologi"]).map(&:staff_id)]
  named_scope :tingkahlaku,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Sains Tingkahlaku"]).map(&:staff_id)]
  named_scope :komunikasi,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Komunikasi & Sains Pengurusan"]).map(&:staff_id)]
  named_scope :ppelatih,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Pembangunan Pelatih"]).map(&:staff_id)]
  named_scope :spelatih,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Khidmat Sokongan Pelatih"]).map(&:staff_id)]
  named_scope :kokurikulum,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Kokurikulum"]).map(&:staff_id)]
  named_scope :kupk,     :conditions =>  ['id in (?) and id NOT IN (?) and assignedto_id in (?) ', Asset.on_loan, AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:all, :conditions=>['unit=?',"Ketua Unit Penilaian & Kualiti"]).map(&:staff_id)]

  named_scope :allloanable,   :conditions =>  ['id in (?)', Asset.on_loan]
  #----------although all asset available for reservation, HIDE user from link to reserve for asset without owner(& dept)----
  #---------so, in order to retrieve only those available asset with owner & dept.....use below named_scope.....
  #special-Asset.find(:all, :conditions=>['assignedto_id is not null and id not in (?)',AssetLoan.find(:all,:conditions=>['is_returned is not true'])])
  named_scope :availableforloan_owndept, :conditions => ['id in (?) and assignedto_id is not null and id not in (?)',Asset.on_loan, AssetLoan.find(:all,:conditions=>['is_returned is not true'])]
  #named_scope :availableforloan_owndept, :conditions => ['assignedto_id is not null and id not in (?) and assignedto_id in (?) ',AssetLoan.find(:all,:conditions=>['is_returned is not true']), Position.find(:all, :conditions=>['unit is not null']) ]

  #named_scope :internal,     :conditions =>  ["id in (?)", AssetLoan.find(:all, :conditions=>["loantype =?",1])]
  #named_scope :external,       :conditions =>  ["loantype =?",2]
  #-------------------------------------------------------------------------------------------------------------------

  FILTERS = [
    {:scope => "all",       :label => I18n.t('asset.all')},
    {:scope => "active",    :label => I18n.t('asset.active')},
    {:scope => "fixed",     :label => I18n.t('asset.fixed_assets')},
    {:scope => "maintainable", :label => I18n.t('asset.maintainable')},
    {:scope => "inventory", :label => I18n.t('asset.inventory')},
    {:scope => "disposal",  :label => I18n.t('asset.for_disposal')},
    {:scope => "disposed",  :label => I18n.t('asset.disposed')},
    {:scope => "markaslost",:label => I18n.t('asset.mark_as_lost')},
    {:scope => "lost",      :label => I18n.t('asset.lost')},
    {:scope => "onloan",    :label => I18n.t('asset.on_loan')},
    {:scope => "pendingloan", :label =>  I18n.t('asset.pending_loan')},
    {:scope => "available", :label => I18n.t('asset.available')}
    ]

    FILTERS_LOAN =[
    {:scope => "allloanable", :label => I18n.t('assetloan.all')},
    {:scope => "availableforloan_owndept", :label => I18n.t('reservable')},
    {:scope => "itdept",    :label => "Teknologi Maklumat"},
    {:scope => "hotelunit",    :label => "Perhotelan"},
    {:scope => "libraryunit", :label => "Perpustakaan"},
    {:scope => "sumbermanusiaunit", :label => "Sumber Manusia"},
    #{:scope => "counterunit", :label => "Kaunter"},
    {:scope => "engineeringunit", :label => "Kejuruteraan"},
    #{:scope => "financestoreunit", :label => "Kewangan & Stor"},
    {:scope => "financeaccountunit", :label => "Kewangan & Akaun"},
    {:scope => "assetstoreunit", :label => "Aset & Stor"},
    #{:scope => "serviceunit", :label => "Perkhidmatan"},
    {:scope => "generaladminunit", :label => "Pentadbiran Am"},
    {:scope => "nursing", :label => "Kejururawatan"},
    {:scope => "radiografi", :label => "Radiografi"},
    {:scope => "fisioterapi", :label => "Fisioterapi" },
    {:scope => "carakerja", :label => "Jurupulih Carakerja"},
    {:scope => "pemperubatan", :label => "Pembantu Perubatan"},
    {:scope => "pengkhususan", :label => "Pengkhususan"},
    {:scope => "perubatanasas", :label => "Perubatan Asas"},
    {:scope => "anatomi", :label => "Anatomi & Fisiologi"},
    {:scope => "tingkahlaku", :label => "Sains Tingkahlaku"},
    {:scope => "komunikasi", :label => "Komunikasi & Pengurusan"},
    {:scope => "ppelatih", :label => "Pembangunan Pelatih"},
    {:scope => "spelatih", :label => "Sokongan Pelatih"},
    {:scope => "kokurikulum", :label => "Unit Kokurikulum"},
    {:scope => "kupk", :label => "Penilaian & Kualiti"}
    ]

    #loaned = AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id)
    #dept = Position.find(:first, :conditions=>['unit=?',"Teknologi Maklumat"]).subtree.map(&:staff_id)
    #@loanables_with_assignedto_dept2= Asset.find(:all,:conditions => ['id NOT IN (?) and assignedto_id in (?) or assetcode ILIKE ? or name ILIKE ? ', AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:first, :conditions=>['unit=?',"Teknologi Maklumat"]).subtree.map(&:staff_id), "#{search2}%", "#{search2}%"])

    #['id NOT IN (?) and assignedto_id in (?) ', AssetLoan.find(:all, :conditions => ['is_returned IS NOT true'], :select => :asset_id).map(&:asset_id), Position.find(:first, :conditions=>['unit=?',"Teknologi Maklumat"]).subtree.map(&:staff_id)]

  #  ,
  #  {:scope => "onloan",    :label => "On Loan"}

    #def self.find_main
      #3Staff.find(:all, :condition => ['staff_id IS NULL'])
    #3end

    #3def self.find_main
       #3AddressBook.find(:all, :condition => ['address_book_id IS NULL'])
    #end

     #def self.find_main
        #Location.find(:all, :condition => ['location_id IS NULL'])
      #end

#---------------------------------Search-------------------------------------------------------------



#----------------------- stuff for category

  #def subcategory_name
 #   subcategory.description if subcategory
  #end

 # def subcategory_name=(name)
 #   self.subcategory = Subcategory.find_by_description(description) unless description.blank?
 # end



#------------------------Declaration----------------------------------------------------
    def bil
       v=1
    end

    def gbtype
      (Asset::ASSETTYPE.find_all{|disp, value| value == assettype}).map {|disp, value| disp}
    end

    def syear
      receiveddate.year.to_s.last(2)
    end


    def sv
      Asset.last.id + 1
    end


    def suggested_serial_no
      st = "KKM/BPL/010619/"
      if assettype == 1
       md = "H/"
       st + md + syear + '/' + cardno                           #added - 4 Oct 2013
      else
       md = "I/"
       st + md + syear + '/' + cardno2 + '-' + quantity.to_s    #added - 4 Oct 2013
      end
      #st + md + syear + '/' + cardno
    end



#-----------------------Coded List-------------------------------------------------------- -

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

def assigned_details
   suid = Array(assignedto_id)
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
    suid = Array(assignedto_id)
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


  COUNTRYLIST = [
             #  Displayed       stored in db
             ["AF|Afghanistan",     93],
             ["AL|Albania",         355],
             ["DZ|Algeria",         213],
             ["AR|Argentina",       54],
             ["AU|Australia",       61],
             ["BR|Brazil",          55],
             ["CA|Canada",          1011],
             ["CN|China",           86],
             ["FI|Finland",         358],
             ["FR|France",          33],
             ["DE|Germany",         49],
             ["HK|Hong Kong",       852],
             ["IN|India",           91],
             ["ID|Indonesia",       62],
             ["IE|Ireland",         353],
             ["IT|Italy",           39],
             ["JP|Japan",           81],
             ["MY|Malaysia",        60],
             ["MX|Mexico",          52],
             ["NZ|New Zealand",     64],
             ["NO|Norway",          47],
             ["PT|Portugal",        351],
             ["ES|Spain",           34],
             ["SE|Sweden",          46],
             ["TW|Taiwan",         886],
             ["TH|Thailand",        66],
             ["TR|Turkey",          90],
             ["GB|United Kingdom",  44],
             ["US|United States",   1]
  ]


    def extralist

    "
    AS|American Samoa, 1684
    AD|Andorra, 376
    AO|Angola, 244
    AI|Anguilla, 1264
    AQ|Antarctica, 672
    AG|Antigua And Barbuda, 1268
    AM|Armenia, 374
    AW|Aruba, 297

    AT|Austria,43
    AZ|Azerbaijan,994
    BS|Bahamas,1242
    BH|Bahrain,973
    BD|Bangladesh, 880
    BB|Barbados, 1246
    BY|Belarus, 375
    BE|Belgium, 32
    BZ|Belize, 501
    BJ|Benin, 229
    BM|Bermuda, 1441
    BT|Bhutan, 975
    BO|Bolivia, 591
    BA|Bosnia And Herzegovina, 387
    BW|Botswana, 267
    BV|Bouvet Island,
    IO|British Indian Ocean Territory,
    BN|Brunei Darussalam, 673
    BG|Bulgaria, 359
    BF|Burkina Faso, 226
    BI|Burundi, 257
    KH|Cambodia, 855
    CM|Cameroon, 237
    CV|Cape Verde, 238
    KY|Cayman Islands, 1345
    CF|Central African Republic, 236
    TD|Chad, 235
    CL|Chile, 56
    CX|Christmas Island, 61
    CC|Cocos (keeling) Islands, 61
    CO|Colombia, 57
    KM|Comoros, 269
    CG|Congo, 242
    CD|Congo, The Democratic Republic Of The, 243
    CK|Cook Islands, 682
    CR|Costa Rica, 506
    CI|Cote D'ivoire,
    HR|Croatia, 385
    CU|Cuba, 53
    CY|Cyprus, 357
    CZ|Czech Republic, 420
    DK|Denmark, 45
    DJ|Djibouti, 253
    DM|Dominica, 1767
    DO|Dominican Republic, 1809
    TP|East Timor
    EC|Ecuador, 593
    EG|Egypt, 20
    SV|El Salvador, 503
    GQ|Equatorial Guinea, 240
    ER|Eritrea, 291
    EE|Estonia, 372
    ET|Ethiopia, 251
    FK|Falkland Islands (malvinas), 500
    FO|Faroe Islands, 298
    FJ|Fiji, 679
    GF|French Guiana,
    PF|French Polynesia, 689
    TF|French Southern Territories
    GA|Gabon, 241
    GM|Gambia, 220
    GE|Georgia, 995
    GH|Ghana, 233
    GI|Gibraltar, 350
    GR|Greece, 30
    GL|Greenland, 299
    GD|Grenada, 1473
    GP|Guadeloupe,
    GU|Guam, 1671
    GT|Guatemala, 502
    GN|Guinea, 224
    GW|Guinea-bissau, 245
    GY|Guyana, 592
    HT|Haiti, 509
    HM|Heard Island And Mcdonald Islands
    VA|Holy See (vatican City State), 39
    HN|Honduras, 504
    HU|Hungary, 36
    IS|Iceland, 354
    IR|Iran, Islamic Republic Of, 98
    IQ|Iraq, 964
    IL|Israel, 972
    JM|Jamaica, 1876
    JO|Jordan, 672
    KZ|Kazakstan, 7
    KE|Kenya, 254
    KI|Kiribati, 686
    KP|Korea, Democratic People's Republic Of
    KR|Korea, Republic Of
    KV|Kosovo, 381
    KW|Kuwait, 965
    KG|Kyrgyzstan, 996
    LA|Lao People's Democratic Republic, 856
    LV|Latvia, 371
    LB|Lebanon, 961
    LS|Lesotho, 266
    LR|Liberia, 231
    LY|Libyan Arab Jamahiriya, 218
    LI|Liechtenstein, 423
    LT|Lithuania, 370
    LU|Luxembourg, 352
    MO|Macau, 853
    MK|Macedonia, The Former Yugoslav Republic Of, 389
    MG|Madagascar, 261
    MW|Malawi, 265
    MV|Maldives, 960
    ML|Mali, 223
    MT|Malta, 354
    MH|Marshall Islands, 692
    MQ|Martinique,
    MR|Mauritania, 222
    MU|Mauritius, 231
    YT|Mayotte, 262
    FM|Micronesia, Federated States Of, 691
    MD|Moldova, Republic Of, 373
    MC|Monaco, 377
    MN|Mongolia, 976
    MS|Montserrat, 1664
    ME|Montenegro, 382
    MA|Morocco, 212
    MZ|Mozambique, 258
    MM|Myanmar, 95
    NA|Namibia. 264
    NR|Nauru, 674
    NP|Nepal, 977
    NL|Netherlands, 31
    AN|Netherlands Antilles, 599
    NC|New Caledonia, 687
    NZ|New Zealand, 64
    NI|Nicaragua, 505
    NE|Niger, 227
    NG|Nigeria, 234
    NU|Niue, 683
    NF|Norfolk Island, 672
    MP|Northern Mariana Islands, 1670
    NO|Norway, 47
    OM|Oman, 968
    PK|Pakistan, 92
    PW|Palau, 680
    PS|Palestinian Territory, Occupied,
    PA|Panama, 507
    PG|Papua New Guinea, 675
    PY|Paraguay, 595
    PE|Peru, 51
    PH|Philippines, 63
    PN|Pitcairn, 870
    PL|Poland, 48
    PT|Portugal, 351
    PR|Puerto Rico, 1012
    QA|Qatar, 974
    RE|Reunion,
    RO|Romania, 40
    RU|Russian Federation, 7
    RW|Rwanda, 250
    SH|Saint Helena, 290
    KN|Saint Kitts And Nevis, 1869
    LC|Saint Lucia, 1758
    PM|Saint Pierre And Miquelon, 508
    VC|Saint Vincent And The Grenadines, 1784
    WS|Samoa, 685
    SM|San Marino, 378
    ST|Sao Tome And Principe, 239
    SA|Saudi Arabia, 966
    SN|Senegal, 221
    RS|Serbia, 381
    SC|Seychelles, 248
    SL|Sierra Leone, 232
    SG|Singapore, 65
    SK|Slovakia, 421
    SI|Slovenia, 386
    SB|Solomon Islands, 677
    SO|Somalia, 252
    ZA|South Africa, 27
    SS|South Sudan,
    GS|South Georgia And The South Sandwich Islands
    ES|Spain, 34
    LK|Sri Lanka, 94
    SD|Sudan, 249
    SR|Suriname, 597
    SJ|Svalbard And Jan Mayen
    SZ|Swaziland, 268
    SE|Sweden, 46
    CH|Switzerland, 41
    SY|Syrian Arab Republic, 963
    TW|Taiwan, Province Of China, 886
    TJ|Tajikistan, 992
    TZ|Tanzania, United Republic Of, 255
    TH|Thailand, 66
    TG|Togo, 228
    TK|Tokelau, 690
    TO|Tonga, 676
    TT|Trinidad And Tobago, 1686
    TN|Tunisia, 216
    TR|Turkey, 90
    TM|Turkmenistan, 993
    TC|Turks And Caicos Islands, 1649
    TV|Tuvalu, 688
    UG|Uganda, 256
    UA|Ukraine, 380
    AE|United Arab Emirates, 971
    GB|United Kingdom, 44
    US|United States, 1
    UM|United States Minor Outlying Islands
    UY|Uruguay, 598
    UZ|Uzbekistan, 998
    VU|Vanuatu, 678
    VE|Venezuela, 58
    VN|Viet Nam, 84
    VG|Virgin Islands, British
    VI|Virgin Islands, U.s.
    WF|Wallis And Futuna, 681
    EH|Western Sahara
    YE|Yemen, 967
    ZM|Zambia, 260
    ZW|Zimbabwe, 263"
  end
end
