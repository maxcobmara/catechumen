class Staffgrade < ActiveRecord::Base
  
  before_save :save_my_vars
  
  has_many :staffclassifications
  has_many :staffserveschemes, :through => :staffclassifications
  
  def save_my_vars
    self.grade = make_grade
  end
  
  def make_grade
    classification_id + level
  end
  
  def classification_name
    (Staffgrade::GROUP.find_all{|disp, value| value == group_id}).map {|disp, value| disp}
  end
  
  def gelas_name
    (Staffgrade::CLASSIFICATION.find_all{|disp, value| value == classification_id}).map {|disp, value| disp}
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
  
  GROUP = [
       #  Displayed       stored in db
       [ "Pengurusan & Professional"    , "P" ],
       [ "Sokongan I"  , "S1" ],
       [ "Sokongan II" , "S2" ],
       [ "Bersepadu" , "B" ]
  ]
end
