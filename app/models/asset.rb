class Asset < ActiveRecord::Base
  
  before_save :save_my_vars
  
  validates_presence_of  :category_id, :typename
  #validates_uniqueness_of :cardno, :scope => :assettype, :message => "This combination code has already been used"
  
  belongs_to :manufacturedby, :class_name => 'Addbook', :foreign_key => 'manufacturer_id'
  belongs_to :suppliedby,     :class_name => 'Addbook', :foreign_key => 'supplier_id'
  belongs_to :location
  belongs_to :assignedto,   :class_name => 'Staff', :foreign_key => 'assignedto_id'
  belongs_to :receivedby,   :class_name => 'Staff', :foreign_key => 'receiver_id'
  belongs_to :category,     :class_name => 'Assetcategory', :foreign_key => 'category_id'
  #belongs_to :subcategory,  :class_name => 'Assetcategory', :foreign_key => 'subcategory_id'
  
  
  has_one :disposal#s        #Link to Model Disposals
  has_one :asset_loss        #Link to Model AssetLoss  
  has_many :assettracks
  #has_many :assetinassettrack,    :class_name => 'Assettrack', :foreign_key => 'asset_id' #Link to Model AssetTrack
  has_many :assetnums
  has_many :maints#, :dependent => :destroy
  accepts_nested_attributes_for :maints, :allow_destroy => true, :reject_if => lambda { |a| a[:asset_id].blank? }
  
 
  def save_my_vars
    if assetcode == nil
      self.assetcode = (suggested_serial_no).to_s
    end
  end
  
  def code_asset
    "#{assetcode} - #{name}"
  end
  

  
  
  #------------------------Filters------------------------------------------------------------
 
  def self.search(search)
     if search
      find(:all, :conditions => ['name ILIKE ? OR typename ILIKE ? OR assetcode ILIKE?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def non_active_assets
    lost = AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)
    disposed = Disposal.find(:all, :select => :asset_id).map(&:asset_id)
    lost + disposed
  end
  
  def assets_that_are_lost
    AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)
  end
  
  def assets_that_are_disposed
    disposed = Disposal.find(:all, :select => :asset_id).map(&:asset_id)
  end
  
  def am_i_gone
    asset = Array(self.id)
    disposed = Disposal.find(:all, :select => :asset_id).map(&:asset_id)
    lost = AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)
    gone = disposed + lost
    am_i = asset & gone
    if am_i == []
      false
    else
      true
    end
  end
 
  named_scope :all 
  named_scope :active,        :conditions =>  ["id not in (?) OR id not in (?)", Disposal.find(:all, :select => :asset_id).map(&:asset_id), AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :fixed,         :conditions =>  ["assettype =? ", 1]
  named_scope :inventory,     :conditions =>  ["assettype =? ", 2]
  named_scope :disposal,      :conditions =>  ["mark_disposal =?",true]# AND id not in (?)", true, Disposal.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :disposed,      :conditions =>  ["id in (?)", Disposal.find(:all, :select => :asset_id).map(&:asset_id)]
  #named_scope :disposal,      :conditions =>  ["mark_disposal =? AND id not in (?)", true, Disposal.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :markaslost,    :conditions =>  ["mark_as_lost =? AND id not in (?)", true, AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)]
  named_scope :lost,          :conditions =>  ["id in (?)", AssetLoss.find(:all, :select => :asset_id).map(&:asset_id)]


  FILTERS = [
    {:scope => "all",       :label => "All"},
    {:scope => "active",    :label => "Active"},
    {:scope => "fixed",     :label => "Fixed Assets"},
    {:scope => "inventory", :label => "Inventory"},
    {:scope => "disposal",  :label => "For Disposal"},
    {:scope => "disposed",  :label => "Disposed"},
    {:scope => "markaslost",:label => "Mark As Lost"},
    {:scope => "lost",      :label => "Lost"}
    ]
  

    #def self.find_main
      #3Staff.find(:all, :condition => ['staff_id IS NULL'])
    #3end
    
    #3def self.find_main
       #3Addbook.find(:all, :condition => ['addbook_id IS NULL'])
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
