class Staffemployscheme < ActiveRecord::Base
  
  has_many :staffemploygrades
  has_many :employgrades, :through => :staffemploygrades
  accepts_nested_attributes_for :staffemploygrades, :reject_if => lambda { |a| a[:employgrade_id].blank? }, :allow_destroy => true 
  
  def gelas_name
    (Staffemployscheme::CLASSIFICATION.find_all{|disp, value| value == glass}).map {|disp, value| disp}
  end
  
  CLASSIFICATION = [
       #  Displayed       stored in db
       [ "A   Pengangkutan"    , "A" ],
       [ "B   Bakat dan Seni"  , "B" ],
       [ "C   Sains"           , "C" ],
       [ "DG  Pendidikan"      , "DG"],
       [ "DGA Pendidikan"      , "DGA" ],
       [ "DM  Pendidikan"      , "DM" ],
       [ "DS  Pendidikan"      , "DS" ],
       [ "DU  Pendidikan"      , "DU" ],
       [ "E   Ekonomi"         , "E" ],
       [ "F   Sistem Maklumat" , "F" ],
       [ "FT  Sistem Maklumat" , "FT" ],
       [ "G   Pertanian"       , "G" ],
       [ "J   Kejuruteraan"    , "J" ],
       [ "KB  Keselamatan & Pertahanan Awam", "KB" ],
       [ "KP  Keselamatan & Pertahanan Awam", "KP" ],
       [ "KR  Keselamatan & Pertahanan Awam", "KR" ],
       [ "KX  Keselamatan & Pertahanan Awam", "KX" ],
       [ "L   Perundangan & Kehakiman", "L" ],
       [ "LS  Perundangan & Kehakiman (Syariah)", "LS" ],
       [ "M   Tadbir & Diplomatik", "M" ],
       [ "N   Pentadbiran & Sokongan", "N" ],
       [ "NT  Pentadbiran & Sokongan", "NT" ],
       [ "Q   Penyelidikan & Pembangunan", "Q" ],
       [ "R   Mahir/Separuh Mahir/Tidak Mahir", "R" ],
       [ "S   Perkhidmatan Sosial", "S" ],
       [ "U   Perubatan & Kesihatan", "U" ],
       [ "W   Kewangan", "W" ],
       [ "X   Penguatkuasa Maritim", "X" ],
       [ "Y   Polis", "Y" ],
       [ "Z   Angkatan Tentera Malaysia", "Z" ]
  ]
  
  
end
