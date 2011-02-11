class Qualification < ActiveRecord::Base
  belongs_to :staff
#  validates_presence_of :level_id, :qname
  
  has_many :level, :class_name => 'Staff', :foreign_key => 'level_id'
  
  
  QTYPE = [
       #  Displayed       stored in db
       [ "Sekolah Rendah", 17 ],
       [ "PMR/SRP dan setaraf", 16],
       [ "SPM/SPVM dan setaraf", 15 ],
       [ "Senior Cambridge Cert", 14 ],
       [ "STPM dan setaraf", 13 ],
       [ "Sijil", 12 ],
       [ "Diploma", 11 ],
       [ "Diploma Lanjutan", 10 ],
       [ "Diploma Lepasan Ijazah", 9 ],
       [ "Sarjana Muda", 8 ],
       [ "Sarjana Muda Kepujian", 7 ],
       [ "Sarjana Persuratan", 6 ],
       [ "Sarjana Sastera", 5 ],
       [ "Sarjana Sains", 4 ],
       [ "Sarjana Perubatan", 3 ],
       [ "Lepasan Sarjana",2 ],
       [ "Doktor Falsafah (Ph.D)",1 ],
       [ "Lain Lain", 99 ]
  ]

end
